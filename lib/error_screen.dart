import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body: Center(child: Text("Error: $error")),
    );
  }
}
