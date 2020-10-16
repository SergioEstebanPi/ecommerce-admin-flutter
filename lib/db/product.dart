import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'products';
  void uploadProduct({
    String productName,
    String brand,
    String category,
    List sizes,
    List images,
    double price,
    int quantity,
  }){
    var id = Uuid();
    String productId = id.v1();
    _firebaseFirestore
        .collection(ref)
        .doc(productId)
        .set({
          'name': productName,
          'brand': brand,
          'category': category,
          'sizes': sizes,
          'images': images,
          'price': price,
          'quantity': quantity,
        });
  }
}