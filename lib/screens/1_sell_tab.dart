//1
// import 'package:flutter/material.dart';

// class SellTabScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sell')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/photo_selection');
//           },
//           child: Text('Help me find items to sell'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SellTabScreen extends StatefulWidget {
  @override
  _SellTabScreenState createState() => _SellTabScreenState();
}

class _SellTabScreenState extends State<SellTabScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Favorites'),
    Text('Sell Page'),  // 現在のタブです
    Text('Inbox'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sell')),
      body: Column(
        children: [
          // 上部のバナー部分
          Container(
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Goodbye selling fees.\nOnly @ Mercari.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  'assets/shoes.jpg', // アセットとして画像を追加
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              // ボタンを配置
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/photo_selection');
                },
                child: Text('Help me find items to sell'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}