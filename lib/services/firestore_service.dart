import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaykommerce/models/kayko_user.dart';
import 'package:kaykommerce/models/order.dart';
import 'package:kaykommerce/models/product.dart';

class FirestoreService {
  final _usersRef = FirebaseFirestore.instance.collection('users');

  final _cartController = StreamController<List<Product>>.broadcast();

  // CART
  Future getOrders(String userId) async {
    try {
      var ordersDocs = await _usersRef.doc(userId).collection('orders').get();
      if (ordersDocs.docs.isNotEmpty) {
        return ordersDocs.docs
            .map((order) => Order.fromMap(order.data(), order.id))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future placeAnOrder(
      String userId, List<Product> products, double totalAmount) async {
    var order = Order(
      amount: totalAmount,
      products: products,
      dateTime: DateTime.now(),
    );
    try {
      await _usersRef.doc(userId).collection('orders').doc().set(order.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future clearCart(String userId) async {
    var ref = _usersRef.doc(userId).collection('cart');
    try {
      await ref.get().then((snap) async {
        for (var docSnap in snap.docs) {
          await ref.doc(docSnap.id).delete();
        }
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future removeFromCart(String userId, String id) async {
    try {
      await _usersRef.doc(userId).collection('cart').doc(id).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToCart(String userId) {
    try {
      _usersRef.doc(userId).collection('cart').snapshots().listen((cartSnaps) {
        if (cartSnaps.docs.isNotEmpty) {
          var prods = cartSnaps.docs
              .map(
                (snap) => Product.fromMap(snap.data()),
              )
              .toList();
          _cartController.add(prods);
        } else {
          _cartController.add([]);
        }
      });
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
    }
    return _cartController.stream;
  }

  Future addProductToCart(String userId, Product product) async {
    try {
      var prodRef = _usersRef.doc(userId).collection('cart').doc(product.id);
      prodRef.get().then((docSnap) => {
            if (docSnap.exists)
              {
                prodRef.update(
                  {
                    'quantity': docSnap.data()!['quantity'] + 1,
                  },
                )
              }
            else
              {
                prodRef.set(
                  product.toMap(),
                ),
              }
          });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // USERS
  Future createUser(KaykoUser user) async {
    try {
      await _usersRef.doc(user.userId).set(user.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      return _usersRef
          .doc(uid)
          .get()
          .then((snapshot) => KaykoUser.fromMap(snapshot.data()!));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
