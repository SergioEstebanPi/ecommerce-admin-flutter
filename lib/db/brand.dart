import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'brands';
  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();
    _firebaseFirestore
        .collection(ref)
        .doc()
        .set({
      'brandId': brandId,
      'brandName': name
    });
  }
  Future getBrands(){
    return _firebaseFirestore
        .collection(ref)
        .get().then((snap) => {
          snap.docs
        });
  }
}