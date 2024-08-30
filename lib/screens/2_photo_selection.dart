import 'package:flutter/material.dart';
// Remove if not needed
import 'package:image_picker/image_picker.dart'; // Add this import
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/types.dart';

class PhotoSelectionScreen extends StatefulWidget {
  const PhotoSelectionScreen({super.key});

  @override
  _PhotoSelectionScreenState createState() => _PhotoSelectionScreenState();
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
                      Response data;
                      try {
                        data = await _sendImagesToBackend(
                            _selectedAmount, _selectedImages);
                      } catch (e) {
                        print('Error: $e');
                        throw Exception('Error: $e');
                      }
                      // すべてのアイテムを表示
                      print('All Items:');
                      for (var item in data.allItems) {
                        print('${item.item}: ${item.price}');
                      }

                      // 選択されたアイテムを表示
                      print('Selected Items Index:');
                      for (var idx in data.selectedIdx) {
                        print(
                            '${data.allItems[idx].item}: ${data.allItems[idx].price}');
                      }

                      // 合計を表示
                      print('Total Sum: ${data.sum}');

                      // image_pathを追加
                      for (var idx = 0; idx < data.allItems.length; idx++) {
                        data.allItems[idx].image = _selectedImages[idx];
                      }

                      // Navigate to the next screen and pass the money amount
                      Navigator.pushNamed(context, '/aiSelection', arguments: {
                        'money': _selectedAmount.toString(),
                        'data': data,
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
