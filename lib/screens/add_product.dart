import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappadmin/db/brand.dart';
import 'package:ecommerceappadmin/db/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productQuantityController = TextEditingController();
  List<QueryDocumentSnapshot> brands = <QueryDocumentSnapshot>[];
  List<QueryDocumentSnapshot> categories = <QueryDocumentSnapshot>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  File _image1;
  File _image2;
  File _image3;

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getBrands();
  }
  List<DropdownMenuItem<String>> getCategoriesDropDown(){
    List<DropdownMenuItem<String>> items = List();
    print('categories length');
    print(categories.length);
    for(int i = 0; i < categories.length; i++){
      setState(() {
        _currentCategory = categories[0]['category'];
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                  categories[i]['category']
              ),
              value: categories[i]['category'],
            )
        );
      });
    }
    return items;
  }
  List<DropdownMenuItem<String>> getBrandsDropDown(){
    List<DropdownMenuItem<String>> items = List();
    print('brands length');
    print(brands.length);
    for(int i = 0; i < brands.length; i++){
      setState(() {
        _currentBrand = brands[0]['brand'];
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(
                  brands[i]['brand']
              ),
              value: brands[i]['brand'],
            )
        );
      });
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: black
          ),
        ),
        title: Text(
            'Add product',
          style: TextStyle(
            color: black
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectedImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery
                              ),
                            1
                          );
                        },
                        borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5
                        ),
                        child: _displayChild1(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectedImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery
                              ),
                              2
                          );
                        },
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5),
                            width: 2.5
                        ),
                        child: _displayChild2(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectedImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery
                              ),
                              3
                          );
                        },
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5),
                            width: 2.5
                        ),
                        child: _displayChild3(),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Enter a product name with 10 characters at maximum',
                  style: TextStyle(
                    color: red,
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product name',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'You must enter the product name';
                    } else if(value.length > 10){
                      return 'Product name cant have more than 10 letters';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Category: ',
                        style: TextStyle(
                          color: red
                        ),
                    ),
                  ),
                  DropdownButton(
                    items: categoriesDropDown,
                    onChanged: changeSelectedCategory,
                    value: _currentCategory,
                  ),
                ]
              ),
              Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brand: ',
                        style: TextStyle(
                            color: red
                        ),
                      ),
                    ),
                    DropdownButton(
                      items: brandsDropDown,
                      onChanged: changeSelectedBrand,
                      value: _currentBrand,
                    ),
                  ]
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: _productQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'You must enter the quantity';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Text('Available sizes'),
              Row(
                children: [
                  Checkbox(
                      value: selectedSizes.contains('XS'),
                      onChanged: (value) => changeSelectedSize('XS'),
                  ),
                  Text('XS'),
                  Checkbox(
                    value: selectedSizes.contains('S'),
                    onChanged: (value) => changeSelectedSize('S'),
                  ),
                  Text('S'),
                  Checkbox(
                    value: selectedSizes.contains('M'),
                    onChanged: (value) => changeSelectedSize('M'),
                  ),
                  Text('M'),
                  Checkbox(
                    value: selectedSizes.contains('L'),
                    onChanged: (value) => changeSelectedSize('L'),
                  ),
                  Text('L'),
                  Checkbox(
                    value: selectedSizes.contains('XL'),
                    onChanged: (value) => changeSelectedSize('XL'),
                  ),
                  Text('XL'),
                  Checkbox(
                    value: selectedSizes.contains('XXL'),
                    onChanged: (value) => changeSelectedSize('XXL'),
                  ),
                  Text('XXL'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: selectedSizes.contains('28'),
                    onChanged: (value) => changeSelectedSize('28'),
                  ),
                  Text('28'),
                  Checkbox(
                    value: selectedSizes.contains('30'),
                    onChanged: (value) => changeSelectedSize('30'),
                  ),
                  Text('30'),
                  Checkbox(
                    value: selectedSizes.contains('32'),
                    onChanged: (value) => changeSelectedSize('32'),
                  ),
                  Text('32'),
                  Checkbox(
                    value: selectedSizes.contains('34'),
                    onChanged: (value) => changeSelectedSize('34'),
                  ),
                  Text('34'),
                  Checkbox(
                    value: selectedSizes.contains('36'),
                    onChanged: (value) => changeSelectedSize('36'),
                  ),
                  Text('36'),
                  Checkbox(
                    value: selectedSizes.contains('38'),
                    onChanged: (value) => changeSelectedSize('38'),
                  ),
                  Text('38'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: selectedSizes.contains('40'),
                    onChanged: (value) => changeSelectedSize('40'),
                  ),
                  Text('40'),
                  Checkbox(
                    value: selectedSizes.contains('42'),
                    onChanged: (value) => changeSelectedSize('42'),
                  ),
                  Text('42'),
                  Checkbox(
                    value: selectedSizes.contains('44'),
                    onChanged: (value) => changeSelectedSize('44'),
                  ),
                  Text('44'),
                  Checkbox(
                    value: selectedSizes.contains('46'),
                    onChanged: (value) => changeSelectedSize('46'),
                  ),
                  Text('46'),
                  Checkbox(
                    value: selectedSizes.contains('48'),
                    onChanged: (value) => changeSelectedSize('48'),
                  ),
                  Text('48'),
                  Checkbox(
                    value: selectedSizes.contains('50'),
                    onChanged: (value) => changeSelectedSize('50'),
                  ),
                  Text('50'),
                ],
              ),
              FlatButton(
                  color: red,
                  textColor: white,
                  onPressed: (){
                    validateAndUpload();
                  },
                  child: Text('Add product')
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0]['category'];
    });
  }
  void changeSelectedCategory(String selectedCategory){
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
  void _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0]['brand'];
    });
  }
  void changeSelectedBrand(String selectedBrand){
    setState(() {
      _currentBrand = selectedBrand;
    });
  }

  void changeSelectedSize(String size) {
    if(selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(
            0,
            size
        );
      });
    }
  }

  void _selectedImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:
        setState(() {
          _image1 = tempImg;
        });
        break;
      case 2:
        setState(() {
          _image2 = tempImg;
        });
        break;
      case 3:
        setState(() {
          _image3 = tempImg;
        });
        break;
      default:
        setState(() {
          _image1 = tempImg;
        });
        break;
    }
  }
  Widget _displayChild1(){
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
            Icons.add,
            color: grey
        ),
      );
    } else {
      return Image.file(
          _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
  Widget _displayChild2(){
    if(_image2 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
            Icons.add,
            color: grey
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
  Widget _displayChild3(){
    if(_image3 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
            Icons.add,
            color: grey
        ),
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() {
    if(_formKey.currentState.validate()){
      if(_image1 != null
          && _image2 != null
          && _image3 != null){
        if(selectedSizes.isNotEmpty){
          String imageUrl;
          final String picture = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        } else {
          Fluttertoast.showToast(
              msg: 'select at least one size'
          );
        }
      } else {
        Fluttertoast.showToast(
            msg: 'all the images must be provided'
        );
      }
    }
  }
}
