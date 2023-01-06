// Add Product Page

// Path: lib\addProduct.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'imports.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProduct createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  // Controllers for the TextFields
  TextEditingController _productName = TextEditingController();
  TextEditingController _productPrice = TextEditingController();
  TextEditingController _productQty = TextEditingController();
  TextEditingController _productType = TextEditingController();

  @override
  // Update State
  void initState() {
    super.initState();
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
      body: Row(
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
                    child: const Text("Add Product",
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
                    child: TextField(
                      maxLength: 15,
                      controller: _productName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Name',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.057),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _productPrice,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Price',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.057),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: _productQty,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Quantity',
                      ),
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
                        print(value);
                        print(_productType.text);
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
                              left: MediaQuery.of(context).size.width * 0.062),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Product()));
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
                              right: MediaQuery.of(context).size.width * 0.062),
                          child: ElevatedButton(
                            onPressed: () {
                              // Add Product to the Database
                              addProduct().then((value) {
                                if (value) {
                                  showAlert1();
                                } else {
                                  showAlert();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Add",
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
    );
  }

  Future<bool> addProduct() async {
    // Add Product to the Database
    if (await Flutter_api().addProduct(_productName.text, _productPrice.text,
        _productQty.text, _productType.text)) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }
}
