import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Remove if not needed
import 'package:image_picker/image_picker.dart'; // Add this import

class PhotoSelectionScreen extends StatefulWidget {
  @override
  _PhotoSelectionScreenState createState() => _PhotoSelectionScreenState();
}

class _PhotoSelectionScreenState extends State<PhotoSelectionScreen> {
  List<XFile> _selectedImages = []; // Use XFile from image_picker
  double _selectedAmount = 0; // New variable to hold the slider value

  // Pick images from gallery
  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
      });
    }
  }

  void _sendImagesToBackend(String moneyAmount, List<XFile> images) {
    // Implement your backend communication here using packages like `http` or `dio`
    // Simulate sending images and receiving URLs
    for (var image in images) {
      // Simulate URL generation from backend
      final imageUrl = 'https://yourbackend.com/uploads/${image.name}';

      // Print the URL + SUCCESS!!! to the terminal
      print('$imageUrl SUCCESS!!!');
    }
    // Implement actual backend communication here using 'http' or 'dio' packages
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              'Automatically find items to sell',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'How much do you want?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Slider(
                  value: _selectedAmount,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _selectedAmount.toStringAsFixed(0),
                  onChanged: (value) {
                    setState(() {
                      _selectedAmount = value;
                    });
                  },
                ),
                Text(
                  'Selected Amount: \$${_selectedAmount.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () async {
                  if (_selectedAmount > 0) {
                    await _pickImages(); // Allow image selection from gallery

                    if (_selectedImages.isNotEmpty) {
                      _sendImagesToBackend(_selectedAmount.toString(), _selectedImages); // Send to backend

                      // Navigate to the next screen and pass the money amount
                      Navigator.pushNamed(context, '/aiSelection', arguments: {
                        'money': _selectedAmount.toString(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sent the image to the backend')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Choose the image you want the AI ​​to classify')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Select an amount greater than 0')),
                    );
                  }
                },
                child: Text(
                  'What images do you want the AI to identify?',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}