import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';
import '../../widgets/add_product_dialog.dart';

import 'product_page.dart';
import 'category_page.dart';

class HomePageGenerated extends StatefulWidget {
  final String? appName;

  const HomePageGenerated({super.key, this.appName});

  @override
  State<HomePageGenerated> createState() => _HomePageGeneratedState();
}

class _HomePageGeneratedState extends State<HomePageGenerated> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final list = await StorageService.loadProducts();

    if (!mounted) return;

    setState(() {
      products = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<String> categories = {'default'};

    for (final p in products) {
      categories.add(p.category);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildCategoryBar(categories),
            const SizedBox(height: 8),
            _buildProductGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7C3AED),
            Color(0xFFE11D48),
          ],
        ),
      ),
      child: Center(
        child: Text(
          widget.appName ?? "Shop",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ================= CATEGORY BAR =================

  Widget _buildCategoryBar(Set<String> categories) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton.icon(
              onPressed: _addCategoryQuick,
              icon: const Icon(Icons.add),
              label: const Text("Add Category"),
            ),
          ),

          ...categories.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ActionChip(
                label: Text(c),
                onPressed: () => _openCategory(c),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PRODUCT GRID =================

  Widget _buildProductGrid() {
    if (products.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("No products yet. Add using + Add Product"),
        ),
      );
    }

    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,

            onTap: () => _openProduct(product),

            onAdd: () {
              StorageService.addToCart(product.id);

              final messenger = ScaffoldMessenger.of(context);

              messenger.clearSnackBars();
              messenger.showSnackBar(
                SnackBar(
                  content: Text("${product.name} added to cart"),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ================= ACTIONS =================

  void _addCategoryQuick() {
    showDialog(
      context: context,
      builder: (_) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text("Add Category"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Category name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Category added. Now add a product under this category.",
                      ),
                    ),
                  );
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addProduct() async {
    final result = await showDialog(
      context: context,
      builder: (_) => const AddProductDialog(
        category: "default",
      ),
    );

    if (result == true) {
      _loadProducts();
    }
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(
          category: category,
        ),
      ),
    ).then((_) => _loadProducts());
  }

  void _openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(
          product: product,
        ),
      ),
    ).then((_) => _loadProducts());
  }
}