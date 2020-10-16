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
          'brand': name,
        });
  }
  Future<List<QueryDocumentSnapshot>> getBrands(){
    Future<List<QueryDocumentSnapshot>> brands = _firebaseFirestore
        .collection(ref)
        .get()
        .then((value) => value.docs);
    return brands;
  }
  Future getSuggestion(String suggestion){
    return _firebaseFirestore
        .collection(ref)
        .where('brand',
        isEqualTo: suggestion)
        .get()
        .then((value) => value.docs);
  }
}