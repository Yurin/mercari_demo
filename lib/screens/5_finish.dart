import 'package:flutter/material.dart';
import 'package:share/share.dart'; 

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing completed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The listing is complete!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/aiSelection'));
              },
              child: const Text('Continue selling'),
            ),
            const SizedBox(height: 10), 
            ElevatedButton(
              onPressed: () {
                // Share functionality
                Share.share('Check out my listing!');
              },
              child: const Text('Share'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Return to the Seller Pages'),
            ),
          ],
        ),
      ),
    );
  }
}