// Add Product Page

// Path: lib\EditProduct.dart
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'imports.dart';

class EditProduct extends StatefulWidget {
  String productID = "";
  String email = "";
  // Get the Product ID in the Constructor
  EditProduct({Key? key, required this.productID, required this.email})
      : super(key: key);

  @override
  _EditProduct createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {
  // Get the Product ID
  String productID = "";
  String email = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Controllers for the TextFields
  TextEditingController _productName = TextEditingController();
  TextEditingController _productPrice = TextEditingController();
  TextEditingController _productQty = TextEditingController();
  TextEditingController _productType = TextEditingController();

  @override
  // Update State
  void initState() {
    super.initState();
    productID = widget.productID;
    email = widget.email;
    getProduct(productID, email).then((value) => {
          setState(() {
            var doc = value[0];
            _productName.text = doc['Name'];
            _productPrice.text = doc['Price'].toString();
            _productQty.text = doc['Quantity'].toString();
          })
        });
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Failed!',
      text: '${_productName.text} Failed to Add !',
    );
  }

  void showAlert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Added!",
      text: '${_productName.text} Product Added !',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Row(
          children: [
            Sidebar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      child: const Text("Edit Product",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        maxLength: 15,
                        controller: _productName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Name',
                          hintMaxLines: 1,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Product Name required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[A-Za-z\s]*$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid Name';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _productPrice,
                        inputFormatters: <TextInputFormatter>[
                          // numbers with points and at least one number after the point
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^\d+\.?\d{0,2}"))
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^\d+\.?\d{0,2}",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid Price';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        controller: _productQty,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^\d+\.?\d{0,2}")),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Product Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      width: MediaQuery.of(context).size.width * 0.6,
                      // Options [Public or Private]
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Public",
                            child: Text("Public"),
                          ),
                          DropdownMenuItem(
                            value: "Private",
                            child: Text("Private"),
                          ),
                        ],
                        onChanged: (value) {
                          _productType.text = value.toString();
                        },
                        hint: const Text("Select Product Visibility"),
                      ),
                    ),
                    // A Row with 2 buttons (left: Cancel, right: Add)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.057),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.062),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const Product()));

                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.062),
                            child: ElevatedButton(
                              onPressed: () {
                                print("Add button pressed");
                                if (formkey.currentState!.validate()) {
                                  updateProduct(
                                          _productName.text,
                                          _productPrice.text,
                                          _productQty.text,
                                          _productType.text,
                                          email,
                                          productID)
                                      .then((value) => {
                                            if (value)
                                              {
                                                showAlert1(),
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Product(),
                                                  ),
                                                ),
                                              }
                                            else
                                              {
                                                showAlert(),
                                              }
                                          });
                                } else {
                                  print("inavlid credentials");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text("Update",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> updataingMapValues(String name, String price, String qty,
    String type, String email, String productID, Map<String, dynamic> map) {
  map.update(
      productID,
      (value) => {
            "Name": name,
            "Price": double.parse(price),
            "Quantity": int.parse(qty),
            "Type": type,
          });

  return map;
}

Future<bool> updateProduct(String name, String price, String qty, String type,
    String email, String productID) async {
  var x = Flutter_api().generateStoreId(email);
  final DATA = await Flutter_api().getAllProducts();

  final map =
      updataingMapValues(name, price, qty, type, email, productID, DATA.map);

  // Updating the Product
  await Firestore.instance.collection("Products").document(x).set(map);

  print("Product Updated");
  return Future<bool>.value(true);
}

Future<List> getProduct(String productID, String email) async {
  List product = [];
  var x = Flutter_api().generateStoreId(email);
  var data = await Firestore.instance
      .collection("Products")
      .document(x)
      .get()
      .then((value) => {
            value.map.forEach((key, value) {
              if (key == productID) {
                // spliting the Document ID to get the Product ID
                var data = {
                  "id": key,
                  "Name": value['Name'],
                  "Price": value['Price'],
                  "Quantity": value['Quantity'],
                  "Type": value['Type'],
                  "Expiry": value['Expiry'],
                  "Category": value['Category'],
                  "StoreId": value['StoreId'],
                  "StoreLocation": value['StoreLocation'],
                  "StoreName": value['StoreName'],
                };
                product.add(data);
              }
            })
          });

  return Future<List>.value(product);
}
