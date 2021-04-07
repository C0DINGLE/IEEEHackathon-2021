import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'cart.dart';

class OrderItem {
  final String id;
  final double quantity;
  final List<BoxItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.quantity,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<BoxItem> boxProducts) {
    _orders.insert(0, OrderItem(id: DateTime.now().toString(), quantity: 1, products: boxProducts, dateTime: DateTime.now()));
    notifyListeners();
   }

}