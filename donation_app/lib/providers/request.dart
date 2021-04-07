import 'package:flutter/foundation.dart';

class Request with ChangeNotifier {
  final String id;
  final String volunteerId;
  final String description;
  final String title;
  final int quantity;
  final String imageUrl;
  String location;
  bool isCompleted;

  Request({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.quantity,
    @required this.imageUrl,
    this.volunteerId,
    this.isCompleted = false,
    this.location,
  });
}