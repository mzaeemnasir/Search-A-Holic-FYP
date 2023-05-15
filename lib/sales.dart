import 'package:firedart/firestore/firestore.dart';
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

  late List recentOrders = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("Getting recent orders...");
    getRecentOrders().then((value) => {
          setState(() {
            recentOrders = value;
          })
        });
  }

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
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text("Sales ID")),
                                      DataColumn(label: Text("Date")),
                                      DataColumn(label: Text("Customer")),
                                      DataColumn(label: Text("Amount")),
                                    ],

                                    rows: [
                                      for (var i = 0;
                                          i < recentOrders.length;
                                          i++)
                                        DataRow(
                                            cells: [
                                              DataCell(Text(recentOrders[i]
                                                      ["saleId"]
                                                  .toString())),
                                              DataCell(Text(recentOrders[i]
                                                      ['saleDate']
                                                  .toString()
                                                  .split(" ")[0])),
                                              DataCell(Text(recentOrders[i]
                                                      ['customerPhone']
                                                  .toString())),
                                              DataCell(Text(recentOrders[i]
                                                      ['saleAmount']
                                                  .toString())),
                                            ],
                                            onLongPress: () {
                                              // showing invoice Dialog
                                              invoiceDiagloge(
                                                  recentOrders[i]["saleId"],
                                                  recentOrders[i]
                                                      ["saleProducts"],
                                                  recentOrders[i]);
                                            }),
                                    ], //rows
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])))
            ])));
  }

  Future<List> getRecentOrders() async {
    var email = await Flutter_api().getEmail();
    var storeId = await Flutter_api().generateStoreId(email);

    var orders = await Firestore.instance
        .collection(storeId)
        .orderBy("saleDate", descending: true)
        .limit(10)
        .get();

    // Creating Sale objects from the documents in the snapshot
    orders.asMap().entries.map((entry) {
      setState(() {
        recentOrders.add({
          "saleId": entry.value.id,
          "saleDate": entry.value["saleDate"],
          "customerPhone": entry.value["customerPhone"],
          "saleAmount": entry.value["saleAmount"],
          "saleProducts": entry.value["saleProducts"],
        });
      });
    }).toList();

    return Future<List>.value(recentOrders);
  }

  // Show Invoice

  // Invoice Dialoge
  Future invoiceDiagloge(String saleId, Map products, Map sel) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              "INVOICE PRODUCTS",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          content: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                    "Date & Time: ${sel['saleDate'].toString().split(" ")[0]}",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 175),
                child: Text("Customer#: ${sel['customerPhone']}",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      print(index.toString());
                      return ListTile(
                        title: Text(products.keys.toList()[index]),
                        subtitle: Text("x ${products.values.toList()[index]}"),
                      );
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
                  trailing: Text('Rs. ${sel['saleAmount']}'),
                ),
              ),
              const Divider(
                thickness: 2,
              ),

              // Add more Text widgets for additional lines of data
            ],
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
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
}
