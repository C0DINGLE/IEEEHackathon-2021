import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String userId;
  String volunteer;
  final String description;
  final String title;
  final int quantity;
  final String imageUrl;
  String category;
  String location;
  bool updates;
  bool isDonated;

  Product({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.quantity,
    @required this.imageUrl,
    this.category,
    this.volunteer,
    this.userId ,
    this.isDonated = false,
    this.location,
    this.updates = false,
  });


  void toggleWishedStatus() {
    isDonated = !isDonated;
    notifyListeners();
  }

}
