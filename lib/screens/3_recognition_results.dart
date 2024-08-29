// import 'package:flutter/material.dart';

// class AISelectionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final category = ModalRoute.of(context)!.settings.arguments as String;

//     final images = ['https://via.placeholder.com/150', 'https://via.placeholder.com/150'];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AI選択画像 - $category'),
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
//                   Navigator.pushNamed(context, '/listing', arguments: images[index]);
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

class AISelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    final images = ['https://via.placeholder.com/150', 'https://via.placeholder.com/150'];

    return Scaffold(
      appBar: AppBar(
        title: Text('AI選択画像 - $category'),
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
                  Navigator.pushNamed(context, '/listing', arguments: images[index]);
                },
                child: Image.network(images[index]),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/listing', arguments: images[0]);
                  },
                  child: Text('デバッグ: 出品画面へ'),
                ),
                SizedBox(height: 10), // Add some spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('売らない'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}