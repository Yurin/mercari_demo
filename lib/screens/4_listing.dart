import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../models/types.dart'; // Ensure this contains your ItemData class

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  Stream<String>? descriptionStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed from the previous screen
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null) {
      final Map<String, dynamic> args = routeArgs as Map<String, dynamic>;
      final ItemData item = args['item'];
      _fetchDescription(item.imageName, item.image!);
    }
  }

  Future<void> _fetchDescription(String name, XFile images) async {
    var detailData = await _getImageDetail(name, images);
    descriptionStream = _createDescriptionStream(detailData.details);
    setState(() {});
  }

  Future<DetailsData> _getImageDetail(String name, XFile images) async {
    // curl  -X POST 'http://localhost:9000/detail' -F 'image=@Downloads/rikasan.png' -F 'name=blue t-shirt'
    var uri = Uri.parse('https://mercari-bold-backend.onrender.com/detail');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;

    var imageBytes = await images.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes('image', imageBytes,
        filename: images.name));

    http.StreamedResponse response;
    try {
      response = await request.send();
    } catch (e) {
      print('Failed to send the request: $e');
      throw Exception('Failed to send the request: $e');
    }

    if (response.statusCode == 200) {
      print('Request Succeeded');
      return DetailsData.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print('Failed with status code: ${response.statusCode}');
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }

  Stream<String> _createDescriptionStream(String detail) async* {
    for (int i = 0; i <= detail.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield detail.substring(0, i);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from AISelectionScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ItemData item = args['item'];
    final String imagePath = args['imagePath'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected image
            Image.network(
              imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'name'),
              keyboardType: TextInputType.text,
              controller: TextEditingController(text: item.item),
            ),
            const SizedBox(height: 16.0),
            // Display the item details
            descriptionStream == null
                ? const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 16.0),
                  )
                : StreamBuilder<String>(
                    stream: descriptionStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Loading...',
                          style: TextStyle(fontSize: 16.0),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(fontSize: 16.0),
                        );
                      } else {
                        return Text(
                          'item: ${snapshot.data}',
                          style: const TextStyle(fontSize: 16.0),
                        );
                      }
                    },
                  ),
            const SizedBox(height: 16.0),
            Text(
              'Category: ${item.category}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(labelText: 'price'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: item.price.toString()),
            ),
            const SizedBox(height: 16.0),
            // Button to submit the listing
            ElevatedButton(
              onPressed: () {
                // Placeholder for the listing process
                Navigator.pushNamed(context, '/listingComplete');
              },
              child: const Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}
