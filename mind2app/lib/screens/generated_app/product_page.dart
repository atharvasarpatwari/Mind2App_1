import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/storage_service.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 16),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "₹ ${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 12),

            if (product.description != null &&
                product.description!.isNotEmpty)
              Text(
                product.description!,
                style: const TextStyle(fontSize: 16),
              ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // ADD TO CART (SAFE, ERROR-FREE)
                      StorageService.addToCart(product.id);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("${product.name} added to cart"),
                        ),
                      );
                    },
                    child: const Text("Add to Cart"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showPaymentDialog(context);
                    },
                    child: const Text("Buy Now"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= IMAGE =================

  Widget _buildImage() {
    if (product.imageDataUrl == null ||
        product.imageDataUrl!.isEmpty) {
      return Container(
        height: 260,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.image, size: 80),
        ),
      );
    }

    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          base64Decode(product.imageDataUrl!),
          height: 260,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      return Container(
        height: 260,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.broken_image, size: 80),
        ),
      );
    }
  }

  // ================= BUY NOW =================

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Gateway"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.payment, size: 60),
            const SizedBox(height: 10),
            Text(
              "Pay ₹ ${product.price.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text("This is a dummy payment screen"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Payment successful (demo)"),
                ),
              );
            },
            child: const Text("Pay Now"),
          ),
        ],
      ),
    );
  }
}
