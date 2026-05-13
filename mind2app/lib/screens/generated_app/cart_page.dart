import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../models/cart_item.dart';

class CartPageGenerated extends StatelessWidget {
  const CartPageGenerated({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: StorageService.loadCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }

        final cart = snapshot.data!;

        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final item = cart[index];
            return ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text("Product ID: ${item.productId}"),
              subtitle: Text("Quantity: ${item.quantity}"),
            );
          },
        );
      },
    );
  }
}
