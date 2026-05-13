import 'package:flutter/material.dart';
import '../../services/storage_service.dart';

class CategoryPage extends StatefulWidget {
  final String category; // NOT required anymore

  const CategoryPage({
    super.key,
    this.category = '', // ✅ DEFAULT VALUE
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await StorageService.listCategories();
    setState(() {
      categories = list;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.isEmpty ? "Categories" : widget.category,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : categories.isEmpty
              ? const Center(child: Text("No categories yet"))
              : ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final c = categories[index];
                    return ListTile(
                      title: Text(c),
                    );
                  },
                ),
    );
  }
}
