import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

class AddProductDialog extends StatefulWidget {
  final String category;
  const AddProductDialog({super.key, required this.category});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final descC = TextEditingController();

  String? imageBase64;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    setState(() {
      imageBase64 = base64Encode(bytes);
    });
  }

  Future<void> _save() async {
    final product = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameC.text,
      price: double.tryParse(priceC.text) ?? 0,
      category: widget.category,
      description: descC.text,
      imageDataUrl: imageBase64,
    );

    await StorageService.addProduct(product);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: priceC, decoration: const InputDecoration(labelText: "Price")),
            TextField(controller: descC, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 10),
            if (imageBase64 != null)
              Image.memory(base64Decode(imageBase64!), height: 120),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: _save, child: const Text("Save")),
      ],
    );
  }
}
