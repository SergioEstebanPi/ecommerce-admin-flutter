import 'package:flutter/material.dart';

enum Page {
  dashboard,
  manage
}

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.dashboard;
                      });
                    },
                    icon: Icon(
                      Icons.dashboard_outlined,
                      color: _selectedPage == Page.dashboard
                        ? active
                        : notActive,
                    ) ,
                    label: Text('Dashboard')
                )
            ),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.manage;
                      });
                    },
                    icon: Icon(
                      Icons.sort_outlined,
                      color: _selectedPage == Page.manage
                          ? active
                          : notActive,
                    ) ,
                    label: Text('Manage')
                )
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _loadScreen(),
    );
  }
  Widget _loadScreen(){
    switch(_selectedPage){
      case Page.dashboard:
        return Column(
          children: [
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.attach_money_outlined,
                    size: 30,
                    color: Colors.green,
                  ),
                  label: Text(
                    '120000',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green
                    ),
                  )
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey
                ),
              ),
            ),
            Expanded(
                child:GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                  ),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.people_alt_outlined
                              ),
                              label: Text('Users')
                          ),
                          subtitle: Text(
                            '7',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: active,
                              fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.category_outlined),
                              label: Text('Categories')
                          ),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: active,
                              fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.shopping_basket_outlined),
                              label: Text('Products')
                          ),
                          subtitle: Text(
                            '120',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: active,
                                fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.tag_faces_outlined),
                              label: Text('Sold')
                          ),
                          subtitle: Text(
                            '13',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: active,
                                fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.shopping_cart_outlined),
                              label: Text('Orders')
                          ),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: active,
                                fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.keyboard_return_outlined),
                              label: Text('Return')
                          ),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: active,
                                fontSize: 60
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add product'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history_outlined),
              title: Text('Products list'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Add category'),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category_outlined),
              title: Text('Category list'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Add brand'),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Brand list'),
              onTap: () {},
            ),
            Divider()
          ],
        );
        break;
      default:
        break;
    }
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if(value.isEmpty){
              return 'Value cannot be empty';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: 'Add category'
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('ADD')
        ),
        FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('CLOSE')
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) => alert
    );
  }
  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if(value.isEmpty){
              return 'Value cannot be empty';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: 'Add brand'
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('ADD'),
        ),
        FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) => alert
    );
  }
}
