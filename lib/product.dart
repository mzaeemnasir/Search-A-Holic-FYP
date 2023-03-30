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
    updateProduct();
    _searchController.addListener(_searchControllerFun);
    products.clear();
  }

  _searchControllerFun() {
    if (_searchController.text != "") {
      setState(() {
        // Filter the products
        products = products
            .where((element) =>
                element.toString().contains(_searchController.text))
            .toList();
        print(products);
      });
    } else {
      setState(() {
        print("Getting PRoduct");
        products.clear();
        updateProduct();
      });
    }
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
                  // Adding Button (Add Product)
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
                            return ProductCard(product: products[index]);
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

  void updateProduct() {
    // Updating the Product

    Flutter_api().getAllProducts().then(
          (value) => {
            value,
            value.map.forEach((key, value) {
              setState(() {
                try {
                  products.add({
                    "Name": value['Name'],
                    "Price": value['Price'],
                    "Quantity": value['Quantity'],
                    "StoreId": value['StoreId'],
                    "ProductId": value['ProductId'],
                    "Type": value['Type'],
                    "id": key,
                  });
                } catch (e) {
                  print(e);
                }
              });
            })
          },
        );
  }

  Future getProducts() async {
    String email = await Flutter_api().getEmail();
    String storeId = await Flutter_api().generateStoreId(email);

    // Getting Documents from Firestore
    var data =
        await Firestore.instance.collection(email).document(storeId).get();
    setState(() {
      products.clear();
      // adding Temp Data to the List
      data.map.forEach((key, value) {
        setState(() {
          products.add({
            "Name": value['Name'],
            "Price": value['Price'],
            "Quantity": value['Quantity'],
            "StoreId": value['StoreId'],
            "ProductId": value['ProductId'],
            "Type": value['Type'],
            "id": key,
          });
        });
      });
    });
    // Getting Documents from Firestore again the email
  }
}
