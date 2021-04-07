import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import './product.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    // id: 'p1',
    // description: 'A red shirt that keeps you warm',
    // title: 'Red Shirt',
    // quantity: 2,
    // imageUrl:
    //     'https://m.media-amazon.com/images/I/61sgfyXajeL._AC_UL640_QL65_.jpg'),
    // Product(
    //     id: 'p2',
    //     description: 'Rice, Chicken Curry and Idli perfect for dinner',
    //     title: 'Some left over cooked food',
    //     quantity: 1,
    //     imageUrl:
    //         'https://www.recipetineats.com/wp-content/uploads/2019/02/Curried-Rice_9.jpg'),
    // Product(
    //     id: 'p3',
    //     description: 'Some left over stationery',
    //     title: 'Stationery Items',
    //     quantity: 5,
    //     imageUrl:
    //         'https://images-eu.ssl-images-amazon.com/images/G/31/img19/OP/revamp/Nov19/V154059123_IN_OP_Shop-by-category-and-brands_revamp_nov19_440x440_8.jpg'),
    // Product(
    //     id: 'p4',
    //     description: 'A used encyclopedia',
    //     title: 'Encyclopedia',
    //     quantity: 1,
    //     imageUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/71TRSyF7haL._AC_SY75_CR,0,0,75,75_.jpg'),
  ];
  List<Product> userProds = [];
  List<Product> catProds = [];

  //var _showWishedOnly = false;

  List<Product> get items {
    // if (_showWishedOnly){
    //   return _items.where((prodItem) => prodItem.isWished).toList();
    // }
    return [..._items];
  }

  List<Product> get donatedItems {
    return _items.where((prodItem) => prodItem.isDonated).toList();
  }

  Product findId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  final User user = auth.currentUser;
  Future<void> fetchUserData() async {
    final User user = auth.currentUser;
    const url = 'https://iaid-7b302.firebaseio.com/donations.json';
    try {
      final response = await http.get(url);
      final extract = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loaded1Prods = [];
      extract.forEach((prodId, prodData) {
        if (prodData['userId'] == user.uid) {
          loaded1Prods.insert(
              0,
              Product(
                id: prodId,
                description: prodData['description'],
                title: prodData['title'],
                quantity: prodData['quantity'],
                imageUrl: prodData['imageUrl'],
                userId: prodData['userId'],
              ));
        }
      });
      userProds = loaded1Prods;
      //print(userProds);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchCat(String titleCat) async {
    const url = 'https://iaid-7b302.firebaseio.com/donations.json';
    try {
      final response = await http.get(url);
      final extract = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loaded2Prods = [];
      extract.forEach((prodId, prodData) {
        if (prodData['category'] == titleCat) {
          loaded2Prods.insert(
              0,
              Product(
                id: prodId,
                description: prodData['description'],
                title: prodData['title'],
                quantity: prodData['quantity'],
                imageUrl: prodData['imageUrl'],
                userId: prodData['userId'],
                category: prodData['category'],
              ));
        }
      });
      catProds = loaded2Prods;
      print(catProds);
      //print(userProds);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchData() async {
    const url = 'https://iaid-7b302.firebaseio.com/donations.json';
    try {
      final response = await http.get(url);
      final extract = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProds = [];

      extract.forEach((prodId, prodData) {
        loadedProds.insert(
            0,
            Product(
              id: prodId,
              description: prodData['description'],
              title: prodData['title'],
              quantity: prodData['quantity'],
              imageUrl: prodData['imageUrl'],
              userId: prodData['userId'],
              location: prodData['location'],
            ));
      });
      _items = loadedProds;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final User userDonor = auth.currentUser;
      const url = 'https://iaid-7b302.firebaseio.com/donations.json';
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'quantity': product.quantity,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isDonated': product.isDonated,
          'userId': userDonor.uid,
          'category': product.category,
          'updates': product.updates,
          'location' : product.location,
        }),
      );

      final newProduct = Product(
        title: product.title,
        quantity: product.quantity,
        description: product.description,
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        category: product.category,
        isDonated: product.isDonated,
        userId: product.userId,
        updates: product.updates,
        location: product.location,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) async {
    final url = 'https://iaid-7b302.firebaseio.com/donations/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(url).then((_) {
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
  }
}
