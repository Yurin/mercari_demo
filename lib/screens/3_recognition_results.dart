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
import '../models/types.dart';

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
        title: const Text('AI選択画像'),
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: itemDataList.allItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listing',
                      arguments: images[index].image?.path);
                },
                child: Column(
                  children: [
                    Image.network(images[index].image?.path ?? ''),
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
                Navigator.pushNamed(context, '/listing',
                    arguments: images[0].image?.path);
              },
              child: const Text('デバッグ: 出品画面へ'),
            ),
          ),
        ],
      ),
    );
  }
}
