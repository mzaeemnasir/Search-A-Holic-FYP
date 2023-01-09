// ignore_for_file: camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:searchaholic/orderCard.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:e_invoice_generator/e_invoice_generator.dart';

import 'imports.dart';

final selectedProducts = [];

class newOrder extends StatefulWidget {
  const newOrder({Key? key}) : super(key: key);
  @override
  _newOrderState createState() => _newOrderState();
}

class _newOrderState extends State<newOrder> {
  final products = [];
  final searchProducts = [];
  int totalBill = 0;
  final quantityController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalBill = 0;

    products.clear();
    searchProducts.clear();
    searchProducts.clear();
    quantityController.clear();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      const Sidebar(),
      Expanded(
        child: Column(
          children: [
            const Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "New Order",
                  style: TextStyle(
                    fontFamily: "NTR",
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ))),
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  // Left Side (Will be Basket)
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // Header of the Barket
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                // Basket Title + Icon
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: const [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Basket",
                                        style: TextStyle(
                                          fontFamily: "NTR",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    // Clear Basket Button
                                    child: Center(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                animType: QuickAlertAnimType
                                                    .slideInRight,
                                                title: "Clear Basket",
                                                text:
                                                    "Are you sure you want to clear the basket?",
                                                onConfirmBtnTap: () {
                                                  setState(() {
                                                    selectedProducts.clear();
                                                    totalBill = 0;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            child: const Text(
                                              "Clear Basket",
                                              style: TextStyle(
                                                fontFamily: "NTR",
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // List View of the Basket
                          Expanded(
                            flex: 8,
                            child: Container(
                              color: const Color.fromARGB(255, 223, 223, 223),
                              height: MediaQuery.of(context).size.height,
                              // List View of the Basket
                              child: ListView.builder(
                                itemCount: selectedProducts.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => {
                                            setState(() {
                                              // Updating the Total Bill
                                              totalBill -= int.parse(
                                                  selectedProducts[index]
                                                          ['price']
                                                      .toString());
                                              selectedProducts.removeAt(index);
                                            })
                                          },
                                      child: OrderCard(
                                        productName: selectedProducts[index]
                                                ['name']
                                            .toString(),
                                        productPrice: selectedProducts[index]
                                                ['price']
                                            .toString(),
                                        productQty: selectedProducts[index]
                                                ['quantity']
                                            .toString(),
                                        productID: selectedProducts[index]['id']
                                            .toString(),
                                      ));
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: const Center(
                                        child: Text(
                                          "TOTAL ",
                                          style: TextStyle(
                                            fontFamily: "NTR",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "Rs. $totalBill",
                                            style: const TextStyle(
                                              fontFamily: "NTR",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      )),
                  // Right Side (Will be Products with Search Bar and Few Buttons)
                  Expanded(
                    child: Column(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 50,
                          ),
                          child: Container(
                            // Search Bar
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search Product",
                                hintStyle: const TextStyle(
                                  fontFamily: "NTR",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: searchQuery,
                            ),
                          ),
                        ),
                      ),
                      // List View of the Products
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 35,
                            right: 30,
                            bottom: 20,
                          ),
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: searchProducts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  // Making a Card for each Product
                                  tileColor:
                                      const Color.fromRGBO(196, 229, 255, 1),
                                  textColor: Colors.black,
                                  title: Text(searchProducts[index]['name']),
                                  subtitle: Text(
                                      "Rs. ${searchProducts[index]['price']}"),
                                  onTap: () {
                                    setState(() {
                                      var i = products.indexWhere((element) =>
                                          element['id'] ==
                                          searchProducts[index]["id"]);
                                      OpenDialoge(
                                          searchProducts[index]["id"], i);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Input User Email
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 100,
                                right: 100,
                                bottom: 10,
                              ),
                              child: SizedBox(
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: const TextStyle(
                                      fontFamily: "NTR",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                    prefixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            // Confirm Button
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // INVOICE
                                    invoiceDiagloge();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: Colors.blue,
                                    // ignore: deprecated_member_use
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text("Checkout"),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }

  // Invoice Dialoge
  Future invoiceDiagloge() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invoice - ${_emailController.text}"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              itemCount: selectedProducts.length + 1,
              itemBuilder: (context, index) {
                if (index == selectedProducts.length) {
                  return ListTile(
                    title: const Text("Total Bill"),

                    trailing: Text("Rs. $totalBill"),
                    // Total Bill
                  );
                } else {
                  var price = "${selectedProducts[index]['price']}";
                  var quantity = "${selectedProducts[index]['quantity']}";

                  return ListTile(
                    title: Text(selectedProducts[index]['name']),
                    subtitle: Text(
                        "Rs. ${selectedProducts[index]['price']} x ${selectedProducts[index]['quantity']}"),
                    // ignore: unnecessary_new
                    trailing: new Text(
                        "Rs. ${int.parse(price) * int.parse(quantity)}"),
                    // Total Bill
                  );
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                if (await Flutter_api().addOrder(selectedProducts, totalBill) ==
                    true) {
                  setState(() {
                    selectedProducts.clear();
                    totalBill = 0;
                  });
                }

                // Adding the Invoice to the Database
                // Updating the Products Quantity
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      );

  Future OpenDialoge(productID, i) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Product Quantity?"),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Quantity",
            ),
            onChanged: ((value) => {
                  if (value.isNotEmpty)
                    {
                      if (int.parse(searchProducts[i]['quantity']) == 0)
                        {quantityController.text = "0"}
                      else if (int.parse(searchProducts[i]['quantity']) <=
                          int.parse(value))
                        {
                          quantityController.text =
                              "${searchProducts[i]['quantity']}"
                        }
                    }
                }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (quantityController.text.isNotEmpty) {
                  setState(() {
                    // Nothing
                  });
                }
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                var index = products
                    .indexWhere((element) => element['id'] == productID);

                if (quantityController.text.isNotEmpty) {
                  if (selectedProducts.contains(products[index])) {
                    setState(() {
                      var qty = int.parse(quantityController.text);
                      var index2 = selectedProducts
                          .indexWhere((element) => element['id'] == productID);
                      selectedProducts[index2]['quantity'] =
                          "${int.parse(selectedProducts[index2]['quantity']) + qty}";
                      totalBill += int.parse(products[index]['price']) * qty;
                    });
                  } else {
                    setState(() {
                      var qty = int.parse(quantityController.text);
                      products[index]['quantity'] = "$qty";
                      selectedProducts.add(products[index]);
                      totalBill += int.parse(products[index]['price']) * qty;
                    });
                  }
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      );

  void searchQuery(String query) {
    if (query.isNotEmpty) {
      var data = products.where((element) {
        var productName = element['name'].toLowerCase();
        return productName.contains(query.toLowerCase());
      }).toList();
      setState(() {
        searchProducts.clear();
        searchProducts.addAll(data);
      });
    } else {
      setState(() {
        // Clearing the search list
        searchProducts.clear();
        searchProducts.addAll(products);
      });
    }
  }

  Future getProducts() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

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
          "quantity": element["productQty"],
        };
        products.add(data);
        searchProducts.add(data);
      });
      // searchProducts.add(products);
    });
    // Getting Documents from Firestore again the email
  }
}
