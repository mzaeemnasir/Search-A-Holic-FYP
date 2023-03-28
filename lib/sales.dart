import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:searchaholic/imports.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:searchaholic/textbox2.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void myalert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Login Faild',
      text: 'Wrong Email or Password',
    );
  }

  void myalert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Login Successful',
      text: '',
    );
  }

  AssetImage newOrder = AssetImage("images/newOrder.png");
  AssetImage searchProduct = AssetImage("images/searchProduct.png");
  AssetImage addProduct = AssetImage("images/addProduct.png");
  AssetImage addCategory = AssetImage("images/addCategory.png");
  AssetImage viewOrders = AssetImage("images/viewOrders.png");
  AssetImage reports = AssetImage("images/report.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: formkey,
            child: Row(children: [
              const Sidebar(),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.057,
                          ),
                          child: Text("Sales Report",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width / 45,
                              )),
                        ),

                        ///Items & Inventory card
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.017,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.16,
                              child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.02,
                                      MediaQuery.of(context).size.height *
                                          0.022,
                                      MediaQuery.of(context).size.width * 0.02,
                                      MediaQuery.of(context).size.height *
                                          0.022,
                                    ),

                                    ///Everything is wrapped into a listview to prevent overflows
                                    child: ListView(
                                      children: [
                                        ///1°st row of buttons
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ///New order
                                            textbox2(
                                                context,
                                                "Today",
                                                const Color.fromRGBO(
                                                    152, 156, 228, 1),
                                                const Color.fromRGBO(
                                                    139, 48, 167, 1),
                                                newOrder),

                                            ///Padding
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),

                                            ///Search product
                                            textbox2(
                                                context,
                                                "Last Month",
                                                const Color.fromRGBO(
                                                    163, 130, 238, 0.886),
                                                const Color.fromRGBO(
                                                    41, 11, 177, 1),
                                                searchProduct),

                                            ///Padding
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),

                                            ///Add product
                                            textbox2(
                                                context,
                                                "Last Year",
                                                const Color.fromRGBO(
                                                    255, 236, 244, 1),
                                                const Color.fromRGBO(
                                                    8, 64, 64, 1),
                                                addProduct),
                                          ],
                                        ),

                                        ///Padding

                                        ///2°nd row of buttons
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sales Details",
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width / 60,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 1000,
                          child: Flexible(
                            child: Scrollbar(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.017,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DataTable(columns: const [
                                    DataColumn(label: Text("Sales ID")),
                                    DataColumn(label: Text("Date")),
                                    DataColumn(label: Text("Customer")),
                                    DataColumn(label: Text("Product")),
                                    DataColumn(label: Text("Quantity")),
                                    DataColumn(label: Text("Amount")),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text('1')),
                                      DataCell(Text('22-03-2023')),
                                      DataCell(Text('32')),
                                      DataCell(Text('Panadol')),
                                      DataCell(Text('2')),
                                      DataCell(Text('30')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('1')),
                                      DataCell(Text('22')),
                                      DataCell(Text('32')),
                                      DataCell(Text('Panadol')),
                                      DataCell(Text('2')),
                                      DataCell(Text('30')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('1')),
                                      DataCell(Text('22')),
                                      DataCell(Text('32')),
                                      DataCell(Text('Panadol')),
                                      DataCell(Text('2')),
                                      DataCell(Text('30')),
                                    ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                    // DataRow(cells: [
                                    //   DataCell(Text('1')),
                                    //   DataCell(Text('22')),
                                    //   DataCell(Text('32')),
                                    //   DataCell(Text('Panadol')),
                                    //   DataCell(Text('2')),
                                    //   DataCell(Text('30')),
                                    // ]),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])))
            ])));
  }
}
