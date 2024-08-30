import 'package:flutter/material.dart';

class PhotoSelectionScreen extends StatefulWidget {
  @override
  _PhotoSelectionScreenState createState() => _PhotoSelectionScreenState();
}

class _PhotoSelectionScreenState extends State<PhotoSelectionScreen> {
  // Text controller to manage input for the dollar amount
  final TextEditingController _moneyController = TextEditingController();

  @override
  void dispose() {
    _moneyController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background
      appBar: AppBar(
        title: Text('You want money, right?'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Question',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Help you roll find items to sell from your camera roll',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'How much money do you want?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            // Text field to input desired dollar amount
            TextFormField(
              controller: _moneyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount in dollars',
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () {
                  // Use the entered dollar amount to navigate to the next screen
                  final moneyAmount = _moneyController.text;
                  if (moneyAmount.isNotEmpty) {
                    Navigator.pushNamed(context, '/aiSelection', arguments: {
                      'money': moneyAmount,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a dollar amount')),
                    );
                  }
                },
                child: Text(
                  'AI search',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
