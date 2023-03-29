// Add Product Page

// Path: lib\addProduct.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'imports.dart';
import 'package:intl/intl.dart';

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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  @override
  // Update State
  void initState() {
    dateinput.text = "";
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
      body: Form(
        key: formkey,
        child: Row(
          children: [
            const Sidebar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                          top: MediaQuery.of(context).size.height * 0.047),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        controller: _productName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.pages),
                          labelText: 'Product Name',
                          hintMaxLines: 1,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Product Name required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[a-zA-Z][a-zA-Z0-9\s]*$",
                              // r"^[A-Za-z0-9 _]*[A-Za-z0-9][A-Za-z0-9 _]*$",
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
                          top: MediaQuery.of(context).size.height * 0.047),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _productPrice,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.price_check),
                          labelText: 'Product Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[0-9]*$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid price';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.047),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        controller: _productQty,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.production_quantity_limits),
                          labelText: 'Product Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[0-9]*$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid Quantity';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.047),
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Center(
                            child: TextField(
                          controller:
                              dateinput, //editing controller of this TextField
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              //icon of text field
                              labelText:
                                  "Enter Expire Date" //label text of field
                              ),

                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ))),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.047),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.08,
                      // Options [Public or Private]
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.visibility),
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
                        hint: const Text(
                          "Select Product Visibility",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.047),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.08,
                      // Options [Public or Private]
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category)),
                        items: const [
                          DropdownMenuItem(
                            value: "Syrup",
                            child: Text("Syrup"),
                          ),
                          DropdownMenuItem(
                            value: "Tablet",
                            child: Text("Tablet"),
                          ),
                          DropdownMenuItem(
                            value: "Capsule",
                            child: Text("Capsule"),
                          ),
                          DropdownMenuItem(
                            value: "Drops",
                            child: Text("Drops"),
                          ),
                          DropdownMenuItem(
                            value: "Other",
                            child: Text("Other"),
                          ),
                        ],
                        onChanged: (value) {
                          _productType.text = value.toString();
                          print(value);
                          print(_productType.text);
                        },
                        hint: const Text("Select Product Category"),
                      ),
                    ),
                    // A Row with 2 buttons (left: Cancel, right: Add)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.047),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.222),
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
                            width: MediaQuery.of(context).size.width * 0.10,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.270),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add Product to the Database
                                if (formkey.currentState!.validate()) {
                                  addProduct().then((value) {
                                    if (value) {
                                      showAlert1();
                                      _productName.clear();
                                      _productPrice.clear();
                                      _productQty.clear();
                                      _productType.clear();
                                    } else {
                                      showAlert();
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
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
