import 'package:flutter/material.dart';

class SellTabScreen extends StatefulWidget {
  @override
  _SellTabScreenState createState() => _SellTabScreenState();
}

class _SellTabScreenState extends State<SellTabScreen> {
  int _selectedIndex = 2; // Default to "Sell" tab

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Favorites'),
    Text('Sell Page'),
    Text('Inbox'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    if (index == 2) { // Only allow changes if the "Sell" tab is selected
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sell')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.PNG'), // Path to your background image asset
            fit: BoxFit.cover, // Fitting the image to cover entire background
          ),
        ),
        child: Column(
          children: [
            // Top banner section
            Container(
              color: Colors.lightBlueAccent.withOpacity(0.8), // Make it slightly transparent
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
                    'assets/shoes.jpg', // Your asset image
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
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

