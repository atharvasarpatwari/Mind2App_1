import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../models/cart_item.dart';

class StorageService {
  static const String _productsKey = 'mind2app_products';
  static const String _cartKey = 'mind2app_cart';

  // ================= PRODUCTS =================

  static Future<List<Product>> loadProducts() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_productsKey);

    if (raw == null || raw.isEmpty) {
      return [];
    }

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Product.fromJson(e)).toList();
  }

  static Future<void> saveProducts(List<Product> products) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(
      _productsKey,
      jsonEncode(products.map((p) => p.toJson()).toList()),
    );
  }

  static Future<void> addProduct(Product product) async {
    final products = await loadProducts();
    products.add(product);
    await saveProducts(products);
  }

  static Future<List<Product>> productsByCategory(String category) async {
    final products = await loadProducts();
    return products.where((p) => p.category == category).toList();
  }

  // ================= CART =================

  static Future<List<CartItem>> loadCart() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getString(_cartKey);

    if (raw == null || raw.isEmpty) {
      return [];
    }

    final List decoded = jsonDecode(raw);
    return decoded.map((e) => CartItem.fromJson(e)).toList();
  }

  static Future<void> addToCart(String productId) async {
    final cart = await loadCart();
    cart.add(CartItem(productId: productId));

    final sp = await SharedPreferences.getInstance();
    await sp.setString(
      _cartKey,
      jsonEncode(cart.map((c) => c.toJson()).toList()),
    );
  }

  static Future<void> clearCart() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_cartKey);
  }

  // ================= CATEGORIES =================

  static Future<List<String>> listCategories() async {
    final products = await loadProducts();
    final set = <String>{};

    for (final p in products) {
      if (p.category.isNotEmpty) {
        set.add(p.category);
      }
    }

    return set.toList();
  }
}
