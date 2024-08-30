import 'package:flutter/material.dart';
import 'screens/1_sell_tab.dart';
import 'screens/2_photo_selection.dart';
import 'screens/3_recognition_results.dart';
import 'screens/4_listing.dart';
import 'screens/5_finish.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // ここで色を変更する
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SellTabScreen(),
        '/photo_selection': (context) => const PhotoSelectionScreen(), 
        '/aiSelection': (context) => const AISelectionScreen(),
        '/listing': (context) => const ListingScreen(),
        '/listingComplete': (context) => const CompleteScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Text('Home Page'),
    const Text('Favorites'),
    const SellTabScreen(), // `sell_tab.dart`を呼び出します
    const Text('Inbox'),
    const Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
