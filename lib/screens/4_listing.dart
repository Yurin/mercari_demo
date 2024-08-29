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
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/listingComplete');
          //     },
          //     child: Text('デバッグ: 出品完了画面へ'),
          //   ),
          // ),
        ],
      ),
    );
  }
}