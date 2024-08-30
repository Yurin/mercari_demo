// import 'package:flutter/material.dart';

// class ListingScreen extends StatelessWidget {
//   const ListingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final selectedImage = ModalRoute.of(context)!.settings.arguments as String;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('出品画面'),
//       ),
//       body: Column(
//         children: [
//           Image.network(selectedImage),
//           const TextField(
//             decoration: InputDecoration(labelText: '商品名'),
//           ),
//           const TextField(
//             decoration: InputDecoration(labelText: '価格'),
//             keyboardType: TextInputType.number,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // 実際の出品処理が追加される場所
//               Navigator.pushNamed(context, '/listingComplete');
//             },
//             child: const Text('出品する'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/types.dart'; // Ensure this contains your ItemData class

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from AISelectionScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ItemData item = args['item'];
    final String imagePath = args['imagePath'];
    final String description = args['description'];

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected image
            Image.network(
              imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            // Display the description passed from the previous screen
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            // TextFields for user input
            const TextField(
              decoration: InputDecoration(labelText: '商品名'),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(labelText: '価格'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            // Button to submit the listing
            ElevatedButton(
              onPressed: () {
                // Placeholder for the listing process
                Navigator.pushNamed(context, '/listingComplete');
              },
              child: const Text('出品する'),
            ),
          ],
        ),
      ),
    );
  }
}

