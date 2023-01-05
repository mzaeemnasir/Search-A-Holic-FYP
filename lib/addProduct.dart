// Add Product Page

// Path: lib\addProduct.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    child: Text("Add Product",
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                          child: Text("Public"),
                          value: "Public",
                        ),
                        DropdownMenuItem(
                          child: Text("Private"),
                          value: "Private",
                        ),
                      ],
                      onChanged: (value) {
                        _productType.text = value.toString();
                        print(value);
                        print(_productType.text);
                      },
                      hint: Text("Select Product Visibility"),
                    ),
                  ),
                  // Cancel and Add Product Buttons
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.057,
                            top: MediaQuery.of(context).size.height * 0.057),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.057,
                            left: MediaQuery.of(context).size.width * 0.47),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add Product to Database
                            if (_productName.text == "" ||
                                _productPrice.text == "" ||
                                _productQty.text == "" ||
                                _productType.text == "") {
                              // Show Error
                              // SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please fill all the fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              print("Add Product to Database");
                            }
                          },
                          child: Text("Add Product"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
