import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:searchaholic/addProduct.dart';
import 'package:searchaholic/imports.dart';
import 'package:searchaholic/productCard.dart';
import 'package:searchaholic/sidebar.dart';

// Product class to Show the Product Details
class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _Product createState() => _Product();
}

class _Product extends State<Product> {
  List<Object> products = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProducts();
    _searchController.addListener(_searchControllerFun);
    products.clear();
  }

  _searchControllerFun() {
    print(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.057,
                    ),
                    child: Text("Products",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 45,
                        )),
                  ),
                  Container(
                    // Search Bar
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.015,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 74, 135, 249),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: // Adding Button (Add Product)
                        Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 74, 135, 249),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                    context, // Adding Product
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddProduct()))
                                .then((value) => getProducts());
                          },
                          child: const Text(
                            "Add Product",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.017,
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.650,
                        child: ListView.builder(
                          // clear the list before adding the new data

                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                                product:
                                    products[index] as Map<String, dynamic>);
                          },
                        )),
                  ),
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
    String email = jsonDecode(file.readAsStringSync())['email'];

    // Getting Documents from Firestore
    var data = await Firestore.instance
        .collection(email)
        .document("Product")
        .collection("products")
        .orderBy("productName", descending: false)
        .get();

    setState(() {
      products.clear();
      // adding Temp Data to the List
      data.forEach((element) {
        // spliting the Document ID to get the Product ID
        var data = {
          "id": element.id,
          "name": element['productName'],
          "price": element['productPrice'],
          "quantity": element['productQty'],
        };
        products.add(data);
      });
    });
    // Getting Documents from Firestore again the email
  }
}
