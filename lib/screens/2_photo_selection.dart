import 'package:flutter/material.dart';

class PhotoSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('写真選択'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/aiSelection', arguments: 'home');
              },
              child: Text('家にありそうなもの'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/aiSelection', arguments: 'personal');
              },
              child: Text('身につけているもの'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/aiSelection', arguments: 'luxury');
              },
              child: Text('高級そうなもの'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/aiSelection', arguments: 'test');
                },
                child: Text('デバッグ: 次の画面へ'),
              ),
            )
          ],
        ),
      ),
    );
  }
}