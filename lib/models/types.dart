import 'package:image_picker/image_picker.dart';

class ItemData {
  final String imageName;
  final String item;
  final double price;
  final int idx;
  final String category;
  late XFile? image;

  ItemData({
    required this.imageName,
    required this.idx,
    required this.item,
    required this.price,
    required this.category,
    required this.image,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      imageName: json['image_name'],
      item: json['item'],
      price: json['price'].toDouble(),
      idx: json['idx'].toInt(),
      category: json['category_name'],
      image: null,
    );
  }
}

class Response {
  final List<ItemData> allItems;
  final List<int> selectedIdx;
  final double sum;

  Response({
    required this.allItems,
    required this.selectedIdx,
    required this.sum,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    // {all_items: [{image_name: cloth.jpg, item: pink tank top, price: 20}, {image_name: shoes.jpg, item: pink sneakers, price: 60}], selected_items: [{image_name: cloth.jpg, item: pink tank top, price: 20}, {image_name: shoes.jpg, item: pink sneakers, price: 60}], sum: 80}
    var all_items = (json['all_items'] as List?)
            ?.map((i) => ItemData.fromJson(i))
            .toList() ??
        [];
    var selected_idx =
        (json['selected_idx'] as List?)?.map((i) => i as int).toList() ?? [];
    var sum = json['sum'];

    return Response(
      allItems: all_items,
      selectedIdx: selected_idx,
      sum: sum,
    );
  }
}

class DetailsData {
  final String name;
  final String details;
  final List<String> keywords;

  DetailsData({
    required this.name,
    required this.details,
    required this.keywords,
  });

  factory DetailsData.fromJson(Map<String, dynamic> json) {
    return DetailsData(
      name: json['name'],
      details: json['details'],
      keywords:
          (json['keywords'] as List?)?.map((i) => i as String).toList() ?? [],
    );
  }
}
