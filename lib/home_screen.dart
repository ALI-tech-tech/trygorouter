import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Page"),
          ElevatedButton(
            onPressed: () => context.go('/details/123'),
            child: Text("Go to Details with ID 123"),
          ),
          ElevatedButton(
            onPressed: () => context.go('/search?q=flutter'),
            child: Text("Search for Flutter"),
          ),
        ],
      ),
    );
  }
}
