import 'package:flutter/material.dart';
import 'package:share/share.dart'; // Add this import if you're using a package for sharing

class CompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('出品完了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('出品が完了しました！'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to '/photo_selection' for continuous listing
                Navigator.pushNamed(context, '/photo_selection');
              },
              child: Text('続けて出品する'),
            ),
            SizedBox(height: 10), // To add space between the buttons
            ElevatedButton(
              onPressed: () {
                // Share functionality
                Share.share('Check out my listing!');
              },
              child: Text('シェアする'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Return to 'Sell' tab
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Sellタブに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}