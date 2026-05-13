import 'package:flutter/material.dart';
import '../models/user_selection.dart';
import 'generated_app/generated_app_pages.dart';

class QuestionnaireScreen extends StatefulWidget {
  final UserSelection selection;
  final String appName;
  final String description;

  const QuestionnaireScreen({super.key, required this.selection, required this.appName, required this.description});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  Widget build(BuildContext context) {
    final sel = widget.selection;
    return Scaffold(
      appBar: AppBar(title: const Text("Choose features")),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Row(children: [
            Expanded(
              child: ListView(padding: const EdgeInsets.all(16), children: [
                const Text("Select which pages you want in the generated app", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                CheckboxListTile(title: const Text("Home Page"), value: sel.homePage, onChanged: (v) => setState(() => sel.homePage = v!)),
                CheckboxListTile(title: const Text("Login Page"), value: sel.loginPage, onChanged: (v) => setState(() => sel.loginPage = v!)),
                CheckboxListTile(title: const Text("Categories Page"), value: sel.categories, onChanged: (v) => setState(() => sel.categories = v!)),
                CheckboxListTile(title: const Text("Product Grid Page"), value: sel.productGrid, onChanged: (v) => setState(() => sel.productGrid = v!)),
                CheckboxListTile(title: const Text("Cart Page"), value: sel.cartPage, onChanged: (v) => setState(() => sel.cartPage = v!)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (!_somethingSelected()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select at least one page")));
                      return;
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (_) => GeneratedAppPages(selection: sel, appName: widget.appName, description: widget.description)));
                  },
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18), child: Text("Generate App")),
                )
              ]),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Card(margin: const EdgeInsets.all(12), elevation: 4, child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
                Text(widget.appName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.description),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text("Live preview (will show selected pages)"),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: [
                  if (sel.homePage) Chip(label: const Text("Home")),
                  if (sel.loginPage) Chip(label: const Text("Login")),
                  if (sel.categories) Chip(label: const Text("Categories")),
                  if (sel.productGrid) Chip(label: const Text("Products")),
                  if (sel.cartPage) Chip(label: const Text("Cart")),
                ])
              ]))),
            )
          ]),
        ),
      ),
    );
  }

  bool _somethingSelected() {
    final s = widget.selection;
    return s.homePage || s.loginPage || s.productGrid || s.categories || s.cartPage;
  }
}
