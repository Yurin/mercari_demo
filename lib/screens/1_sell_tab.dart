import 'package:flutter/material.dart';

class SellTabScreen extends StatefulWidget {
  @override
  _SellTabScreenState createState() => _SellTabScreenState();
}

class _SellTabScreenState extends State<SellTabScreen> {
  int _selectedIndex = 2;  // Default to "Sell" tab

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Favorites'),
    Text('Sell Page'),
    Text('Inbox'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {  // Only allow changes if the "Sell" tab is selected
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seller Page')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),  // Path to your background image asset
            fit: BoxFit.cover,  // Fitting the image to cover entire background
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment(0.0, -0.0),  // Shift button up slightly
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/photo_selection');
                  },
                  child: Text('Help me find items to sell'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 60),  // Set minimum button size
                  ),
                ),
              ),
            ),
          ],
        ),
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
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}