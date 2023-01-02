import 'dart:convert';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:searchaholic/imports.dart';
import 'package:searchaholic/sidebar.dart';

// Product class to Show the Product Details
class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _Product createState() => _Product();
}

class _Product extends State<Product> {
  List<Object> products = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.087,
                      ),
                      child: Text("Products",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 45,
                          ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getProducts() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');

    try {
      String email = jsonDecode(file.readAsStringSync())['email'];

      // Getting Documents from Firestore
      var data = Firestore.instance.collection(email).document("Product");
      var snapshot = await data.get();
    } catch (e) {
      print(e);
      // Alert Dialog to Show the Error
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Something went wrong"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"))
              ],
            );
          });
    }

    // Getting Documents from Firestore again the email
  }
}
