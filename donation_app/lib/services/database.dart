import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class DatabaseService {

  String uid;
  DatabaseService({this.uid});

  // Users collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData({String username, String number, String role, String email, String password}) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'role': role,
      'username': username,
      'number': number,
      'password': password,
      'image_url': "",
    });
  }

  Future saveImage(PickedFile image) async {
    final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(uid + '.jpg');

        await ref.putFile(File(image.path));

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({
          'image_url': url,
          });
  }

   // get user doc stream
  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots();
  }
  

}