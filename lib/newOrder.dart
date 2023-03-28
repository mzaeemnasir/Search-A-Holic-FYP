// ignore_for_file: camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:searchaholic/orderCard.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:e_invoice_generator/e_invoice_generator.dart';
import 'package:intl/intl.dart';
import 'package:share_whatsapp/share_whatsapp.dart';
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  dynamic Store_name;
  dynamic Email;
  dynamic Phone_number;
  dynamic address_l1, address_l2;
  dynamic date;
  dynamic msg;
  //dynamic password;

  ///getting profile data from databae
  Future getprofile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];

    // Getting Documents from Firestore
    var data = Firestore.instance.collection(email);
    var data1 = data.document('Store Details');
    var data2 = await data1.get();

    setState(() {
      Store_name = data2['storeName'];
      Email = data2['email'];
      Phone_number = data2['phNo'];
      address_l1 = data2['lat'];
      address_l2 = data2['long'];
      //password = data2['password'];
    });
  }

  Future getDateandTime() async {
    var now = DateTime.now();
    var formatter = DateFormat.yMMMMd().add_jm();
    String formattedDate = formatter.format(now);
    setState(() {
      date = formattedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    totalBill = 0;

    products.clear();
    searchProducts.clear();
    searchProducts.clear();
    quantityController.clear();
    getProducts();
    getprofile();
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
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Row(
                                  children: [
                                    // Basket Title + Icon
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: const [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
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
                                    SizedBox(
                                      width: 120,
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
                                  ],
                                ),
                              )),
                          // List View of the Basket
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              //padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey[200],
                                ),
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
                                                selectedProducts
                                                    .removeAt(index);
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
                                          productID: selectedProducts[index]
                                                  ['id']
                                              .toString(),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20))),
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
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20))),
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
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
                                ),
                              ))
                        ],
                      )),
                  // Right Side (Will be Products with Search Bar and Few Buttons)
                  Expanded(
                    child: Column(children: [
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 20,
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.only()),
                            onChanged: searchQuery,
                          ),
                        ),
                      ),

                      // List View of the Products
                      Flexible(
                        flex: 55,
                        fit: FlexFit.tight,
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
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Card(
                                      elevation: 2,
                                      color: Colors.blue[300],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        // Making a Card for each Product
                                        title: Text(
                                          searchProducts[index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          "Rs. ${searchProducts[index]['price']}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            var i = products.indexWhere(
                                                (element) =>
                                                    element['id'] ==
                                                    searchProducts[index]
                                                        ["id"]);
                                            OpenDialoge(
                                                searchProducts[index]["id"], i);
                                          });
                                        },
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Row(
                              children: [
                                // Input User Email
                                Flexible(
                                    child: Form(
                                  key: formkey,
                                  child: TextFormField(
                                    maxLines: 1,
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number required';
                                      } else {
                                        RegExp regExp = RegExp(
                                          r"^[0-9]{11}$",
                                          caseSensitive: false,
                                          multiLine: false,
                                        );
                                        if (!regExp.hasMatch(value)) {
                                          // Make input field red
                                          return 'Please enter a valid phone number';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Phone Number",
                                        hintStyle: const TextStyle(
                                          fontFamily: "NTR",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 10),
                                          child: Icon(Icons.phone),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.only()),
                                  ),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                // Confirm Button
                                SizedBox(
                                  height: 43,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        // INVOICE
                                        getDateandTime();

                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.warning,
                                          title: 'Prescription Confirmation',
                                          text:
                                              'Have you checked the prescription?',
                                          onConfirmBtnTap: () =>
                                              invoiceDiagloge(),
                                        );
                                      }
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
                                )
                              ],
                            )),
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
          title: Padding(
            padding: const EdgeInsets.only(left: 150),
            child: Text(
              "$Store_name",
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          //Text("Invoice - ${_emailController.text}"),
          content: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text("Sales Invoice",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 280),
                child: Text("Address: $address_l1,$address_l2",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 235),
                child: Text("Tel #: $Phone_number",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Text("Date & Time: $date",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 175),
                child: Text("Customer Tel #: ${_emailController.text}",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Scrollbar(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
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
              ),
              const Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: Text(
                    'Total discount',
                  ),
                  trailing: Text('0'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: Text(
                    'Sales Tax %',
                  ),
                  trailing: Text('0'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: const Text(
                    'Total Amount',
                  ),
                  trailing: Text('$totalBill'),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Thank You for choosing $Store_name",
                    style: const TextStyle(fontSize: 11, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("For feedback @ $Email",
                    style: const TextStyle(fontSize: 11, color: Colors.black)),
              ),

              // Add more Text widgets for additional lines of data
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, // Adding Product
                    MaterialPageRoute(builder: (context) => const newOrder()));
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  msg =
                      "$Store_name\nSales Invoice\nAddress: $address_l1,$address_l2\nTel #: $Phone_number\nDate & Time: $date\nCustomer Tel #: ${_emailController.text}\n${selectedProducts[0]['name']}  Rs. ${selectedProducts[0]['price']} x ${selectedProducts[0]['quantity']}\nSales Tax:0\nDiscount:0\nTotal Amount:$totalBill\nThank You for choosing $Store_name\nFor feedback @ $Email\n";
                });
                shareWhatsapp.share(
                  text: msg,
                  // change with real whatsapp number
                  phone: '+92${_emailController.text}',
                );
                // ignore: unused_local_variable

                Navigator.pop(context);
                if (await Flutter_api().addOrder(selectedProducts, totalBill) ==
                    true) {
                  setState(() {
                    selectedProducts.clear();
                    totalBill = 0;
                  });
                }
                Navigator.push(
                    context, // Adding Product
                    MaterialPageRoute(builder: (context) => const newOrder()));

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
