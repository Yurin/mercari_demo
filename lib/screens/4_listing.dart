import 'package:flutter/material.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedImage = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('出品画面'),
      ),
      body: Column(
        children: [
          Image.network(selectedImage),
          const TextField(
            decoration: InputDecoration(labelText: '商品名'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: '価格'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              // 実際の出品処理が追加される場所
              Navigator.pushNamed(context, '/listingComplete');
            },
            child: const Text('出品する'),
          ),
        ],
      ),
    );
  }
}

