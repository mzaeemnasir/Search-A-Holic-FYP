// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:searchaholic/sidebar.dart';
import 'package:searchaholic/textBox.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firedart.dart';
import 'dart:convert';
import 'package:searchaholic/imports.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic Store_name;
  dynamic Email;
  dynamic Phone_number;
  dynamic address_l1, address_l2;

  ///getting profile data from databae
  Future getprofile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    try {
      if (!file.existsSync()) {
        print("File does not exist");
      } else if (file.lengthSync() == 0) {
        print("File is empty");
      } else {
        String fileContent = file.readAsStringSync();
        var json = jsonDecode(fileContent);
        String email = json['email'];

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
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
// Update State

  var revenue = 0.0;
  var sale = 0.0;
  var orders = 0.0;
  String email = "";

  @override
  void initState() {
    super.initState();
    getprofile();
    super.initState();
  }

  // Importing Images For the Text Boxes
  AssetImage newOrder = AssetImage("images/newOrder.png");
  AssetImage searchProduct = AssetImage("images/searchProduct.png");
  AssetImage addProduct = AssetImage("images/addProduct.png");
  AssetImage addCategory = AssetImage("images/addCategory.png");
  AssetImage viewOrders = AssetImage("images/viewOrders.png");
  AssetImage reports = AssetImage("images/report.png");

  // Constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Sidebar(),
        Expanded(
          child: Container(
              child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Column(
              children: [
                ///Store name
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.087,
                  ),
                  child: Text(
                    '$Store_name',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width / 45,
                    ),
                  ),
                ),

                ///Today's report
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today's report",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width / 55,
                    ),
                  ),
                ),

                ///Today's report card
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.017,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ///Revenue
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01,
                            ),
                            child: Card(
                              elevation: 1,
                              color: Colors.grey[100],
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///Text
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Revenue",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  55,
                                            ),
                                          ),
                                          Text(
                                            "Rs. " + revenue.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  80,
                                            ),
                                          )
                                        ],
                                      ),

                                      ///Padding
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                      ),

                                      ///Icon
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007),
                                        child: Image(
                                          image: AssetImage(
                                              "images/revenue_icon.png"),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),

                          ///Sale
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.075,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01,
                            ),
                            child: Card(
                              elevation: 1,
                              color: Colors.grey[100],
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///Text
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sale",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  55,
                                            ),
                                          ),
                                          Text(
                                            "Rs. " + sale.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  80,
                                            ),
                                          )
                                        ],
                                      ),

                                      ///Padding
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                      ),

                                      ///Icon
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007),
                                        child: Image(
                                          image: AssetImage(
                                              "images/sale_icon.png"),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),

                          ///Orders
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.01,
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              left: MediaQuery.of(context).size.width * 0.057,
                              right: MediaQuery.of(context).size.width * 0.0009,
                            ),
                            child: Card(
                              elevation: 1,
                              color: Colors.grey[100],
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///Text
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Orders",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  55,
                                            ),
                                          ),
                                          Text(
                                            "Rs. " + orders.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  80,
                                            ),
                                          )
                                        ],
                                      ),

                                      ///Padding
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                      ),

                                      ///Icon
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007),
                                        child: Image(
                                          image: AssetImage(
                                              "images/orders_icon.png"),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                ///Items & Inventory
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Items & Inventory",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width / 45,
                    ),
                  ),
                ),

                ///Items & Inventory card
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.017,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.022,
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.022,
                          ),

                          ///Everything is wrapped into a listview to prevent overflows
                          child: ListView(
                            children: [
                              ///1°st row of buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///New order
                                  textBox(
                                      context,
                                      "New Order",
                                      Color.fromRGBO(152, 156, 228, 1),
                                      Color.fromRGBO(168, 204, 236, 1),
                                      newOrder),

                                  ///Padding
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),

                                  ///Search product
                                  textBox(
                                      context,
                                      "Search Product",
                                      Color.fromRGBO(255, 196, 116, 0.9),
                                      Color.fromRGBO(255, 172, 124, 1),
                                      searchProduct),

                                  ///Padding
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),

                                  ///Add product
                                  textBox(
                                      context,
                                      "Add Product",
                                      Color.fromRGBO(128, 194, 255, 1),
                                      Color.fromRGBO(53, 253, 253, 1),
                                      addProduct),
                                ],
                              ),

                              ///Padding
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),

                              ///2°nd row of buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///Add Categories
                                  textBox(
                                      context,
                                      "Upload Data",
                                      Color.fromRGBO(255, 162, 180, 1),
                                      Color.fromRGBO(255, 162, 180, 0.95),
                                      addCategory),

                                  ///Padding
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),

                                  ///View All Orders
                                  textBox(
                                      context,
                                      "View Sales",
                                      Color.fromRGBO(184, 204, 252, 1),
                                      Color.fromRGBO(252, 212, 244, 1),
                                      viewOrders),

                                  ///anything
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),

                                  ///anything
                                  textBox(
                                    context,
                                    "Report",
                                    Color.fromRGBO(248, 207, 127, 1),
                                    Color.fromRGBO(184, 206, 132, 1),
                                    reports,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          )),
        )
      ],
    ));
  }
}
