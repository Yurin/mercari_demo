// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/types.dart';

// // Screen that displays a list of items passed from the previous page
// class AISelectionScreen extends StatelessWidget {
//   const AISelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve arguments as a Map
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     final String money = args['money'];
//     final Response itemDataList = args['data'];
//     List<ItemData> images = [];
//     for (var idx in itemDataList.selectedIdx) {
//       images.add(itemDataList.allItems[idx]);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MerBudget'),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(8.0),
//         itemCount: images.length,
//         itemBuilder: (context, index) {
//           final item = images[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 4.0),
//             child: ListTile(
//               leading: Image.network(
//                 item.image!.path,
//                 width: 70,
//                 height: 70,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(item.item),
//               subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
//               onTap: () {
//                 // Navigate to another screen or perform any action when an item is tapped
//                 Navigator.pushNamed(context, '/listing',
//                     arguments: {'item': item});
//               },
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             // Trigger recommendation action or navigate
//           },
//           child: const Text('Get Recommendation'),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/types.dart'; // Ensure this contains your ItemData and Response classes

// Screen that displays a list of items passed from the previous page
class AISelectionScreen extends StatelessWidget {
  const AISelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments as a Map
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String money = args['money'];
    final Response itemDataList = args['data'];

    // Prepare a list of selected images
    List<ItemData> selectedItems = [];
    List<ItemData> notSelectedImages = [];
    for (var idx = 0; idx < itemDataList.allItems.length; idx++) {
      if (itemDataList.selectedIdx.contains(idx)) {
        selectedItems.add(itemDataList.allItems[idx]);
      } else {
        notSelectedImages.add(itemDataList.allItems[idx]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MerBudget'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          final item = selectedItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              leading: Image.network(
                item.image!.path,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
              title: Text(item.item),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              onTap: () {
                // Navigate to the ListingScreen with item data as arguments
                Navigator.pushNamed(
                  context,
                  '/listing',
                  arguments: {
                    'item': item,
                    'imagePath': item.image!.path,
                    'description':
                        item.item, // You can pass other details as well
                  },
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Trigger recommendation action or navigate
          },
          child: const Text('Get Recommendation'),
        ),
      ),
    );
  }
}
