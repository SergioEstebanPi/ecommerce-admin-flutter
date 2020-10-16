import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappadmin/db/brand.dart';
import 'package:ecommerceappadmin/db/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _productNameController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _getCategories();
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){

                      },
                      borderSide: BorderSide(
                        color: grey.withOpacity(0.5),
                        width: 2.5
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
                        child: Icon(
                          Icons.add,
                          color: grey
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){

                      },
                      borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
                        child: Icon(
                            Icons.add,
                            color: grey
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){

                      },
                      borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
                        child: Icon(
                            Icons.add,
                            color: grey
                        ),
                      ),
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
            Visibility(
              visible: _currentCategory != null,
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              _currentCategory ?? "null",
                              style: TextStyle(
                                color: white
                              ),
                            )
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              color: white
                            ),
                            onPressed: (){
                              setState(() {
                                _currentCategory = '';
                              });
                            }
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'add category'
                  )
              ),
              suggestionsCallback: (pattern) async {
                return await _categoryService.getSuggestion(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.category_outlined),
                  title: Text(suggestion['category'])
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _currentCategory = suggestion['category'];
                });
              },
            ),
            Visibility(
              visible: _currentBrand != null,
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              _currentBrand ?? "null",
                              style: TextStyle(
                                  color: white
                              ),
                            )
                        ),
                        IconButton(
                            icon: Icon(
                                Icons.close,
                                color: white
                            ),
                            onPressed: (){
                              setState(() {
                                _currentBrand = '';
                              });
                            }
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'add brand'
                  )
              ),
              suggestionsCallback: (pattern) async {
                return await _brandService.getSuggestion(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                    leading: Icon(Icons.branding_watermark),
                    title: Text(suggestion['brand'])
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _currentBrand = suggestion['brand'];
                });
              },
            ),
            Center(
              child: DropdownButton(
                value: _currentCategory,
                items: categoriesDropDown,
                onChanged: changeSelectedCategory,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
    });
  }
  void changeSelectedCategory(String selectedCategory){
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
}
