import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String userId;
  final String category;

  UserProductItem(this.id, this.title, this.imageUrl, this.userId, this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: 
        IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: () {},
          color: Theme.of(context).errorColor,
        ),
    );
  }
}
