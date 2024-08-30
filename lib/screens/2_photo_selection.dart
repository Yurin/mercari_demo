import 'package:flutter/material.dart';
// Remove if not needed
import 'package:image_picker/image_picker.dart'; // Add this import
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

class PhotoSelectionScreen extends StatefulWidget {
  const PhotoSelectionScreen({super.key});

  @override
  _PhotoSelectionScreenState createState() => _PhotoSelectionScreenState();
}

class ItemData {
  final String imageName;
  final String item;
  final double price;

  ItemData({
    required this.imageName,
    required this.item,
    required this.price,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      imageName: json['image_name'],
      item: json['item'],
      price: json['price'].toDouble(),
    );
  }
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
    // {all_items: [{image_name: cloth.jpg, item: pink tank top, price: 20}, {image_name: shoes.jpg, item: pink sneakers, price: 60}], selected_items: [{image_name: cloth.jpg, item: pink tank top, price: 20}, {image_name: shoes.jpg, item: pink sneakers, price: 60}], sum: 80}
    var all_items = (json['all_items'] as List?)
            ?.map((i) => ItemData.fromJson(i))
            .toList() ??
        [];
    var selected_items = (json['selected_items'] as List)
        .map((i) => ItemData.fromJson(i))
        .toList();
    var sum = json['sum'];

    return Response(
      allItems: all_items,
      selectedItems: selected_items,
      sum: sum,
    );
  }
}

class _PhotoSelectionScreenState extends State<PhotoSelectionScreen> {
  List<XFile> _selectedImages = []; // Use XFile from image_picker
  double _selectedAmount = 0; // New variable to hold the slider value

  // Pick images from gallery
  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
      });
    }
  }

  Future<Response> _sendImagesToBackend(
      double moneyAmount, List<XFile> images) async {
    var uri = Uri.parse('http://localhost:9000/analyze');
    var request = http.MultipartRequest('POST', uri);
    request.fields['budget'] = moneyAmount.toString();

    for (var image in images) {
      if (kIsWeb) {
        var bytes = await image.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes('images', bytes,
            filename: image.name));
      } else {
        request.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      }
    }

    http.StreamedResponse response;
    try {
      response = await request.send();
    } catch (e) {
      print('Failed to send the request: $e');
      throw Exception('Failed to send the request: $e');
    }

    if (response.statusCode == 200) {
      print('Request Succeeded');
      return Response.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print('Failed with status code: ${response.statusCode}');
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('You want money, right?'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Question',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            const Text(
              'Automatically find items to sell',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () async {
                  if (_selectedAmount > 0) {
                    await _pickImages(); // Allow image selection from gallery

                    if (_selectedImages.isNotEmpty) {
                      try {
                        Response data = await _sendImagesToBackend(
                            _selectedAmount,
                            _selectedImages); // Send to backend

                        // すべてのアイテムを表示
                        print('All Items:');
                        for (var item in data.allItems) {
                          print('${item.item}: ${item.price}');
                        }

                        // 選択されたアイテムを表示
                        print('Selected Items:');
                        for (var item in data.selectedItems) {
                          print('${item.item}: ${item.price}');
                        }

                        // 合計を表示
                        print('Total Sum: ${data.sum}');
                      } catch (e) {
                        print('Error: $e');
                      }

                      // Navigate to the next screen and pass the money amount
                      Navigator.pushNamed(context, '/aiSelection', arguments: {
                        'money': _selectedAmount.toString(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Sent the image to the backend')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Choose the image you want the AI ​​to classify')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Select an amount greater than 0')),
                    );
                  }
                },
                child: const Text(
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
