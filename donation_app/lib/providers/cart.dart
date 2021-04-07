import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class BoxItem {
  final String id;
  final String title;
  final double quantity;
  final String imageUrl;
  //final int boxSize;

  BoxItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.imageUrl,
    //@required this.boxSize,
  });
}
class Box with ChangeNotifier {
  Map<String, BoxItem> _items = {};

  Map<String, BoxItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, boxItem) {
      total += boxItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    String title,
    int quantity,
    String imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingBoxItem) => BoxItem(
          id: existingBoxItem.id,
          title: existingBoxItem.title,
          quantity: existingBoxItem.quantity + 1,
          imageUrl: existingBoxItem.imageUrl,
        ),
      );
    } else {
      print(_items);

      _items.putIfAbsent(
        productId,
        () => BoxItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingBoxItem) => BoxItem(
          id: existingBoxItem.id,
          title: existingBoxItem.title,
          quantity: existingBoxItem.quantity - 1,
          imageUrl: existingBoxItem.imageUrl,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
