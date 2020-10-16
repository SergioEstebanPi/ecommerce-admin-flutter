import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'categories';
  void createCategory(String name){
    var id = Uuid();
    String categoryId = id.v1();
    _firebaseFirestore
        .collection(ref)
        .doc(categoryId)
        .set({
          'category': name
        });
  }
  Future<List<QueryDocumentSnapshot>> getCategories(){
    Future<List<QueryDocumentSnapshot>> categories = _firebaseFirestore
        .collection(ref)
        .get()
        .then((value) => value.docs);
    return categories;
  }
  Future getSuggestion(String suggestion){
    return _firebaseFirestore
        .collection(ref)
        .where('category',
          isEqualTo: suggestion)
        .get()
        .then((value) => value.docs);
  }
}