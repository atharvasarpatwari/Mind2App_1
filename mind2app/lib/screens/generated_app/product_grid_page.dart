import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';
import 'product_page.dart';

class ProductGridGenerated extends StatefulWidget {
  const ProductGridGenerated({super.key});

  @override
  State<ProductGridGenerated> createState() => _ProductGridGeneratedState();
}

class _ProductGridGeneratedState extends State<ProductGridGenerated> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await StorageService.loadProducts();
    setState(() => products = list);
  }

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(child: Text("No products yet"))
        : Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: products
                  .map((p) => ProductCard(
                        product: p,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: p))).then((_) => _load()),
                        onAdd: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${p.name} added (demo)"))),
                      ))
                  .toList(),
            ),
          );
  }
}
