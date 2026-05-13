import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(child: _image()),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(product.name),
            ),
            Text("₹ ${product.price.toStringAsFixed(0)}"),
            ElevatedButton(onPressed: onAdd, child: const Text("Add")),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    if (product.imageDataUrl == null || product.imageDataUrl!.isEmpty) {
      return const Center(child: Icon(Icons.image));
    }

    return Image.memory(
      base64Decode(product.imageDataUrl!),
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
