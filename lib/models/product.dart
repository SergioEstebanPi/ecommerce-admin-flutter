import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  // constants
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String COLORS = 'colors';
  static const String FEATURED = 'featured';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String PRICE = 'price';
  static const String QUANTITY = 'quantity';
  static const String SALE = 'sale';
  static const String SIZE = 'size';

  // private variables
  String _brand;
  String _category;
  String _id;
  String _name;
  String _picture;
  double _price;
  int _quantity;
  List<String> _colors;
  List<String> _size;
  bool _featured;
  bool _sale;

  // getters
  String get brand => _brand;
  String get category => _category;
  String get id => _id;
  String get name => _name;
  String get picture => _picture;
  double get price =>_price;
  int get quantity => _quantity;
  List<String> get colors => _colors;
  List<String> get size =>_size;
  bool get feature => _featured;
  bool get sale => _sale;

  Product.fromSnapshot(DocumentSnapshot snapshot){
    _brand = snapshot.get(FEATURED);
    _category = snapshot.get(BRAND);
    _id = snapshot.get(ID);
    _name = snapshot.get(NAME);
    _picture = snapshot.get(PICTURE);
    _price = snapshot.get(PRICE);
    _quantity = snapshot.get(QUANTITY);
    _colors = snapshot.get(COLORS);
    _size = snapshot.get(SIZE);
    _featured = snapshot.get(FEATURED);
    _sale = snapshot.get(SALE);
  }
}