import 'package:flutter/material.dart';
import '../../models/user_selection.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'product_grid_page.dart';
import 'cart_page.dart';
import 'category_page.dart';

class GeneratedAppPages extends StatefulWidget {
  final UserSelection selection;
  final String appName;
  final String description;

  const GeneratedAppPages({
    super.key,
    required this.selection,
    required this.appName,
    required this.description,
  });

  @override
  State<GeneratedAppPages> createState() => _GeneratedAppPagesState();
}

class _GeneratedAppPagesState extends State<GeneratedAppPages> {
  late final List<_PageEntry> pages;

  @override
  void initState() {
    super.initState();

    pages = [];

    if (widget.selection.homePage) {
      pages.add(_PageEntry(
        title: 'Home',
        widget: HomePageGenerated(appName: widget.appName),
      ));
    }

    if (widget.selection.loginPage) {
      pages.add(_PageEntry(
        title: 'Login',
        widget: const LoginPageGenerated(),
      ));
    }

    if (widget.selection.productGrid) {
      pages.add(_PageEntry(
        title: 'Products',
        widget: const ProductGridGenerated(),
      ));
    }

    if (widget.selection.categories) {
      pages.add(_PageEntry(
        title: 'Categories',
        widget: const CategoryPage(),
      ));
    }

    if (widget.selection.cartPage) {
      pages.add(_PageEntry(
        title: 'Cart',
        widget: const CartPageGenerated(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appName),
          bottom: TabBar(
            isScrollable: true,
            tabs: pages.map((p) => Tab(text: p.title)).toList(),
          ),
        ),
        body: TabBarView(
          children: pages.map((p) => p.widget).toList(),
        ),
      ),
    );
  }
}

class _PageEntry {
  final String title;
  final Widget widget;

  _PageEntry({required this.title, required this.widget});
}
