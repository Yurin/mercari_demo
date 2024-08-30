import 'package:image_picker/image_picker.dart';

class ItemData {
  final String imageName;
  final String item;
  final double price;
  final int idx;
  late XFile? image;

  ItemData({
    required this.imageName,
    required this.idx,
    required this.item,
    required this.price,
    required this.image,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      imageName: json['image_name'],
      item: json['item'],
      price: json['price'].toDouble(),
      idx: json['idx'].toInt(),
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
