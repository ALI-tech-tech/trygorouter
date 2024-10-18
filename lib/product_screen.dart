import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Product $index"),
            onTap: () => context.go('/products/item/$index'),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product $productId")),
      body: Center(child: Text("Details for Product ID: $productId")),
    );
  }
}
