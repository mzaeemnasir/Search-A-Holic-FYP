import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
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
                  Padding(padding: EdgeInsets.only(top: 20)),
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
                  Padding(padding: EdgeInsets.only(top: 25)),
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.017,
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.73,
                        child: ListView.builder(
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
    var data = Firestore.instance
        .collection(email)
        .document("Product")
        .collection("products")
        .orderBy("name")
        .get();

    setState(() {
      // adding Temp Data to the List
      products = [
        {
          "name": "Product 1",
          "price": "100",
          "quantity": "10",
          "description": "Product 1 Description"
        },
        {
          "name": "Product 2",
          "price": "200",
          "quantity": "20",
          "description": "Product 2 Description"
        },
        {
          "name": "Product 3",
          "price": "300",
          "quantity": "30",
          "description": "Product 3 Description"
        },
        {
          "name": "Product 4",
          "price": "400",
          "quantity": "40",
          "description": "Product 4 Description"
        },
        {
          "name": "Product 5",
          "price": "500",
          "quantity": "50",
          "description": "Product 5 Description"
        },
        {
          "name": "Product 6",
          "price": "600",
          "quantity": "60",
          "description": "Product 6 Description"
        },
        {
          "name": "Product 7",
          "price": "700",
          "quantity": "70",
          "description": "Product 7 Description"
        },
        {
          "name": "Product 8",
          "price": "800",
          "quantity": "80",
          "description": "Product 8 Description"
        },
        {
          "name": "Product 9",
          "price": "900",
          "quantity": "90",
          "description": "Product 9 Description"
        },
        {
          "name": "Product 10",
          "price": "1000",
          "quantity": "100",
          "description": "Product 10 Description"
        },
        {
          "name": "Product 11",
          "price": "1100",
          "quantity": "110",
          "description": "Product 11 Description"
        },
        {
          "name": "Product 12",
          "price": "1200",
          "quantity": "120",
          "description": "Product 12 Description"
        },
        {
          "name": "Product 13",
          "price": "1300",
          "quantity": "130",
          "description": "Product 13 Description"
        },
        {
          "name": "Product 14",
          "price": "1400",
          "quantity": "140",
          "description": "Product 14 Description"
        },
        {
          "name": "Product 15",
          "price": "1500",
          "quantity": "150",
          "description": "Product 15 Description"
        },
      ];
    });

    // Getting Documents from Firestore again the email
  }
}
