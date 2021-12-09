import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Nike Shoe',
      description: 'A white Nike shoe for running!',
      price: 49.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/19/18/06/feet-1840619_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Samsung Galaxy Note Edge',
      description: 'Brand new black Samsung Galaxy Note Edge',
      price: 649.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/03/27/19/36/samsung-galaxt-note-edge-1283897_1280.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Gloves',
      description: 'Wool gloves - winter, warm',
      price: 11.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2018/12/20/11/47/gloves-3885830_1280.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Coffee Mug',
      description: 'Simple teal color coffee&tea mug',
      price: 9.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/01/02/04/59/coffee-1117933_1280.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Iphone 5',
      description: 'White Iphone 5',
      price: 799.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/08/05/10/30/iphone-410324_1280.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Calculator',
      description: 'Black classic calculator',
      price: 24.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/07/06/13/55/calculator-385506_1280.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Converse Shoe',
      description: 'Converse All Star - lightweight, canvas, different colors',
      price: 39.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2017/06/09/18/19/sneakers-2387874_1280.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Highlighter',
      description: 'Green highlighter - top quality',
      price: 3.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2013/07/13/09/47/highlighter-156032_1280.png',
    ),
    Product(
      id: 'p9',
      title: 'Jeans',
      description: 'Classic short jeans',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/07/23/15/55/jeans-6487623_1280.jpg',
    ),
    Product(
      id: 'p10',
      title: 'Backpack',
      description: 'Black 50L Outdoor backpack',
      price: 39.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/22/19/25/man-1850181_1280.jpg',
    ),
  ];

  var _showFavouritesOnly = false;

  List<Product> get items {
    if (_showFavouritesOnly) {
      return _items.where((prodItem) => prodItem.isFavourite).toList();
    }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.singleWhere((prod) => prod.id == id, orElse: () => null);
  }

  // void showFavouritesOnly() {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) {
    final url = Uri.https(
        'flutter-shopping-app-f9912-default-rtdb.europe-west1.firebasedatabase.ap',
        '/products.json');
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavourite': product.isFavourite,
        },
      ),
    )
        .then((response) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // adds new product at the start of the list
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
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

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
