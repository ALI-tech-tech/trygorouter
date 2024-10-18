import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class DetailScreen extends StatelessWidget {
  final String id;

  DetailScreen({required this.id});

  void _shareLink() {
    // Construct the deep link URL
    final link = 'https://yourapp.com/details/$id';
    
    // Use Share Plus to share the link
    Share.share('Check out this detail: $link', subject: 'Detail for item $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Details for item: $id"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareLink, // Share the deep link
              child: Text("Share this Link"),
            ),
          ],
        ),
      ),
    );
  }
}
