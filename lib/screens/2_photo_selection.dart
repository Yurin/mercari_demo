import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Remove if not needed
import 'package:image_picker/image_picker.dart'; // Add this import
import 'package:http/http.dart' as http;

class PhotoSelectionScreen extends StatefulWidget {
  @override
  _PhotoSelectionScreenState createState() => _PhotoSelectionScreenState();
}
class Response {
  final List<ItemData> allItems;
  final List<ItemData> selectedItems;
  final double sum;

  Response({
    required this.allItems,
    required this.selectedItems,
    required this.sum,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      allItems: (json['all_items'] as List)
          .map((item) => ItemData.fromJson(item))
          .toList(),
      selectedItems: (json['selected_items'] as List)
          .map((item) => ItemData.fromJson(item))
          .toList(),
      sum: json['sum'].toDouble(),
    );
  }
}

class ItemData {
  // ItemDataのプロパティを定義
  // 例：
  final String id;
  final String name;
  final double price;

  ItemData({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}

class _PhotoSelectionScreenState extends State<PhotoSelectionScreen> {
  final TextEditingController _moneyController = TextEditingController();
  List<XFile> _selectedImages = []; // Use XFile from image_picker

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

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

  Future<Response> _sendImagesToBackend(String moneyAmount, List<XFile> images) async {
    var url = Uri.parse('https://mercari-bold-backend.onrender.com/analyze');
    var request = http.MultipartRequest('POST', url);

    // Add money amount to request
    request.fields['budget'] = moneyAmount;
    
    // Add images to request
    for (var image in images) {
      request.files.add(await http.MultipartFile.fromPath('images', image.path));
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Request Succeeded');
        return Response.fromJson(jsonDecode(response.body));
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to send the request: $e');
    }
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
            TextFormField(
              controller: _moneyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter the amount in dollars',
                border: OutlineInputBorder(),
              ),
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
                  final moneyAmount = _moneyController.text;
                  if (moneyAmount.isNotEmpty) {
                    await _pickImages(); // Allow image selection from gallery

                    if (_selectedImages.isNotEmpty) {

                      try {
                        Response data = await _sendImagesToBackend(moneyAmount, _selectedImages); // Send to backend
                        
                        // すべてのアイテムを表示
                        print('All Items:');
                        for (var item in data.allItems) {
                          print('${item.name}: ${item.price}');
                        }

                        // 選択されたアイテムを表示
                        print('Selected Items:');
                        for (var item in data.selectedItems) {
                          print('${item.name}: ${item.price}');
                        }

                        // 合計を表示
                        print('Total Sum: ${data.sum}');

                      } catch (e) {
                        print('Error: $e');
                      }

                      // Navigate to the next screen and pass the money amount
                      Navigator.pushNamed(context, '/aiSelection', arguments: {
                        'money': moneyAmount,
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
                      SnackBar(content: Text('Enter your amount')),
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

