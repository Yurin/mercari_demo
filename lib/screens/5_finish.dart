import 'package:flutter/material.dart';

class CompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('出品完了'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('出品が完了しました！'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sellタブ画面に戻る
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Sellタブに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}