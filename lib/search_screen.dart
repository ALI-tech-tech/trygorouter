import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String? query;

  const SearchScreen({this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Page")),
      body: Center(child: Text("Search Query: ${query ?? 'No Query'}")),
    );
  }
}
