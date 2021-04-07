import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import './request.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Requests with ChangeNotifier {
  List<Request> _allRequests = [];
  List<Request> userReq = [];

  List<Request> get allRequests {
    return [..._allRequests];
  }

  List<Request> get completedRequests {
    return _allRequests.where((reqItem) => reqItem.isCompleted).toList();
  }

  Request findId(String id) {
    return _allRequests.firstWhere((req) => req.id == id);
  }

  final User user = auth.currentUser;
  Future<void> fetchUserData() async {
    const url = 'https://iaid-7b302.firebaseio.com/requests.json';
    try {
      final response = await http.get(url);
      final extract = json.decode(response.body) as Map<String, dynamic>;
      final List<Request> loaded1reqs = [];
      extract.forEach((reqId, reqData) {
        if (reqData['volunteerId'] == user.uid) {
          loaded1reqs.insert(
              0,
              Request(
                id: reqId,
                description: reqData['description'],
                title: reqData['title'],
                quantity: reqData['quantity'],
                imageUrl: reqData['imageUrl'],
                volunteerId: reqData['volunteerId'],
                location: reqData['location'],
              ));
        }
      });
      userReq = loaded1reqs;
      //print(userreqs);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchData() async {
    const url = 'https://iaid-7b302.firebaseio.com/requests.json';
    try {
      final response = await http.get(url);
      final extract = json.decode(response.body) as Map<String, dynamic>;
      final List<Request> loadedReq = [];

      extract.forEach((reqId, reqData) {
        loadedReq.insert(
            0,
            Request(
              id: reqId,
              description: reqData['description'],
              title: reqData['title'],
              quantity: reqData['quantity'],
              imageUrl: reqData['imageUrl'],
              volunteerId: reqData['volunteerId'],
              location: reqData['location'],
            ));
      });
      _allRequests = loadedReq;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addRequest(Request request) async {
    try {
      final User userVol = auth.currentUser;
      const url = 'https://iaid-7b302.firebaseio.com/requests.json';
      final response = await http.post(
        url,
        body: json.encode({
          'title': request.title,
          'quantity': request.quantity,
          'description': request.description,
          'imageUrl': request.imageUrl,
          'isCompleted': request.isCompleted,
          'volunteerId': userVol.uid,
          'location': request.location,
        }),
      );

      final newRequest = Request(
        title: request.title,
        quantity: request.quantity,
        description: request.description,
        id: json.decode(response.body)['name'],
        imageUrl: request.imageUrl,
        location: request.location,
        isCompleted: request.isCompleted,
        volunteerId: request.volunteerId,
      );
      _allRequests.add(newRequest);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void updateRequest(String id, Request newRequest) {
    final reqIndex = _allRequests.indexWhere((req) => req.id == id);
    if (reqIndex >= 0) {
      _allRequests[reqIndex] = newRequest;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteRequest(String id) {
    _allRequests.removeWhere((req) => req.id == id);
    notifyListeners();
  }
}
