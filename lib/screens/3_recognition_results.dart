// // import 'package:flutter/material.dart';

// // class ImageData {
// //   final String imageUrl;
// //   final String item;
// //   final int price;

// //   ImageData({required this.imageUrl, required this.item, required this.price});
// // }

// // class AISelectionScreen extends StatelessWidget {
// //   const AISelectionScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Retrieve arguments as a Map
// //     final Map<String, String> selectedCategories =
// //         ModalRoute.of(context)!.settings.arguments as Map<String, String>;

// //     // Example list of images with additional information
// //     final List<ImageData> images = [
// //       ImageData(imageUrl: 'https://via.placeholder.com/150', item: 'Jacket', price: 100),
// //       ImageData(imageUrl: 'https://via.placeholder.com/150', item: 'Shirt', price: 50),
// //     ];

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('AI選択画像'),
// //       ),
// //       body: Stack(
// //         children: [
// //           GridView.builder(
// //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //             ),
// //             itemCount: images.length,
// //             itemBuilder: (context, index) {
// //               return GestureDetector(
// //                 onTap: () {
// //                   Navigator.pushNamed(context, '/listing',
// //                       arguments: images[index].imageUrl);
// //                 },
// //                 child: Column(
// //                   children: [
// //                     Image.network(images[index].imageUrl),
// //                     Text(images[index].item),
// //                     Text('\$${images[index].price}'),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamed(context, '/listing', arguments: images[0].imageUrl);
// //               },
// //               child: const Text('デバッグ: 出品画面へ'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class ImageData {
//   final String imageUrl;
//   final String item;
//   final int price;

//   ImageData({required this.imageUrl, required this.item, required this.price});
// }

// class Response {
//   final List<ItemData> allItems;
//   final List<ItemData> selectedItems;
//   final double sum;

//   Response({required this.allItems, required this.selectedItems, required this.sum});
// }

// class ItemData {
//   final String imageName;
//   final String item;
//   final double price;

//   ItemData({required this.imageName, required this.item, required this.price});
// }

// class AISelectionScreen extends StatelessWidget {
//   const AISelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve arguments as a Map
//     final Map<String, dynamic> arguments =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     final String moneyAmount = arguments['money'];
//     final Response responseData = arguments['response'];

//     // Use the data from responseData instead of the example list
//     final List<ItemData> images = responseData.allItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AI選択画像'),
//       ),
//       body: Stack(
//         children: [
//           GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/listing',
//                       arguments: images[index].imageName);
//                 },
//                 child: Column(
//                   children: [
//                     Image.network(images[index].imageName), // Assuming imageName is a URL here
//                     Text(images[index].item),
//                     Text('\$${images[index].price.toStringAsFixed(0)}'),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/types.dart';

// Screen that displays a list of items passed from the previous page
class AISelectionScreen extends StatelessWidget {
  const AISelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments as a Map
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String money = args['money'];
    final Response itemDataList = args['data'];
    var images = itemDataList.allItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MerBudget'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final item = images[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.network(
                item.imageName,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item.item),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              onTap: () {
                // Navigate to another screen or perform any action when an item is tapped
                Navigator.pushNamed(context, '/listing',
                    arguments: {'item': item});
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Trigger recommendation action or navigate
          },
          child: const Text('Get Recommendation'),
        ),
      ),
    );
  }
}
