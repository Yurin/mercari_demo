// import 'package:flutter/material.dart';

// class AISelectionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Retrieve arguments as a Map
//     final Map<String, String> selectedCategories =
//         ModalRoute.of(context)!.settings.arguments as Map<String, String>;

//     // You can use these selectedCategories to filter images or perform operations
//     final images = [
//       'https://via.placeholder.com/150',
//       'https://via.placeholder.com/150'
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AI選択画像'),
//       ),
//       body: Stack(
//         children: [
//           GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/listing',
//                       arguments: images[index]);
//                 },
//                 child: Image.network(images[index]),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/listing', arguments: images[0]);
//               },
//               child: Text('デバッグ: 出品画面へ'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ImageData {
  final String imageUrl;
  final String item;
  final int price;

  ImageData({required this.imageUrl, required this.item, required this.price});
}

class AISelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments as a Map
    final Map<String, String> selectedCategories =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    // Example list of images with additional information
    final List<ImageData> images = [
      ImageData(imageUrl: 'https://via.placeholder.com/150', item: 'Jacket', price: 100),
      ImageData(imageUrl: 'https://via.placeholder.com/150', item: 'Shirt', price: 50),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('AI選択画像'),
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listing',
                      arguments: images[index].imageUrl);
                },
                child: Column(
                  children: [
                    Image.network(images[index].imageUrl),
                    Text(images[index].item),
                    Text('\$${images[index].price}'),
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listing', arguments: images[0].imageUrl);
              },
              child: Text('デバッグ: 出品画面へ'),
            ),
          ),
        ],
      ),
    );
  }
}