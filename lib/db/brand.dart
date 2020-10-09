import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();
    _firebaseFirestore
        .collection('brands')
        .doc()
        .set({
      'brandId': brandId,
      'brandName': name
    });
  }
}