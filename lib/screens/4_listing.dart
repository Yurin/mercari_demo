import 'package:flutter/material.dart';

class ListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedImage = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('出品画面'),
      ),
      body: Column(
        children: [
          Image.network(selectedImage),
          TextField(
            decoration: InputDecoration(labelText: '商品名'),
          ),
          TextField(
            decoration: InputDecoration(labelText: '価格'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              // 実際の出品処理が追加される場所
              Navigator.pushNamed(context, '/listingComplete');
            },
            child: Text('出品する'),
          ),
        ],
      ),
    );
  }
}

// //複数の画像に対応したバーション？
// class ListingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final selectedImages = ModalRoute.of(context)!.settings.arguments as List<String>;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('出品画面'),
//       ),
//       body: Column(
//         children: [
//           // ListViewやColumnを使って複数の画像を表示
//           Expanded(
//             child: ListView.builder(
//               itemCount: selectedImages.length,
//               itemBuilder: (context, index) {
//                 return Image.network(selectedImages[index]);
//               },
//             ),
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: '商品名'),
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: '価格'),
//             keyboardType: TextInputType.number,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // 実際の出品処理が追加される場所
//               Navigator.pushNamed(context, '/listingComplete');
//             },
//             child: Text('出品する'),
//           ),
//         ],
//       ),
//     );
//   }
// }