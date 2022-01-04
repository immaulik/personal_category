import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:personal_category/Providers/auth.dart';
import 'package:personal_category/screens/authscreen.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    TextEditingController controller = TextEditingController();
    final databaseRef = FirebaseDatabase.instance.ref().child('category');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category-App'),
        actions: [
          IconButton(
            onPressed: () async {
              Dialog errorDialog = Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0)), //this right here
                child: Container(
                  height: 150.0,
                  width: 300.0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: controller,
                            decoration:
                                InputDecoration(hintText: 'Enter category'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            onPressed: () {
                              String text = controller.text;
                              if (text.isEmpty) {
                                print('enter');
                              } else {
                                databaseRef.push().set({
                                  'name': text,
                                  'comment': 'A good season',
                                });
                                Navigator.of(context);
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              showDialog(
                  context: context,
                  builder: (BuildContext context) => errorDialog);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 20,
        unselectedIconTheme: IconThemeData(color: Colors.blue),
        selectedIconTheme: IconThemeData(color: Colors.amberAccent),
        selectedItemColor: Colors.amberAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: "Location",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_sharp),
            label: "Chart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rounded_corner),
            label: "Round",
          ),
        ],
      ),
    );
  }
}
