import 'package:flutter/material.dart';
import 'package:share/share.dart'; // Add this import if you're using a package for sharing

class CompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing completed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The listing is complete!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to '/photo_selection' for continuous listing
                Navigator.pushNamed(context, '/photo_selection');
              },
              child: Text('Continue selling'),
            ),
            SizedBox(height: 10), // To add space between the buttons
            ElevatedButton(
              onPressed: () {
                // Share functionality
                Share.share('Check out my listing!');
              },
              child: Text('Share'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Return to 'Sell' tab
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Return to the Seller Pages'),
            ),
          ],
        ),
      ),
    );
  }
}