// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firedart/firedart.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firedart/generated/google/firestore/v1/document.pb.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:searchaholic/product.dart';
// import 'package:searchaholic/sidebar.dart';
// import 'package:d_chart/d_chart.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';
// import 'imports.dart';
// import 'dart:convert';

// class biCharts extends StatefulWidget {
//   const biCharts({super.key});
//   @override
//   _biChartsState createState() => _biChartsState();
// }

// // TooltipBehavior _tooltipBehavior;

// class _biChartsState extends State<biCharts> {
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   var revenue = 0.0;
//   var sale = 0.0;
//   var orders = 0.0;
//   String email = "";

//   Map<DateTime, int> dataMap = {};
//   Map<String, int> dailyDataMap = {};

//   late List<Salesdata> Salesdata1 = [];
//   late List<SalesData> Salesdata2 = [];

//   @override
//   void initState() {
//     super.initState();
//     getData().then((value) => {
//           setState(() {
//             Salesdata1 = value;
//           })
//         });
//   }

//   // @override
//   // void initState() {
//   //   _tooltipBehavior = TooltipBehavior(enable: true);
//   //   super.initState();
//   // }

//   // final streamdata = FirebaseFirestore.instance
//   //     .collection('65a763ce21e3932ef41844bfd6a48f79')
//   //     .snapshots(includeMetadataChanges: true);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Row(children: [
//       const Sidebar(),
//       Expanded(
//           child: ListView(
//         padding: const EdgeInsets.all(8),
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(
//               left: MediaQuery.of(context).size.width * 0.04,
//               right: MediaQuery.of(context).size.width * 0.015,
//             ),
//             child: Column(children: [
//               const Padding(padding: EdgeInsets.only(top: 20)),
//               Padding(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.057,
//                   ),
//                   child: Text("Report's",
//                       style: TextStyle(
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.w600,
//                         fontSize: MediaQuery.of(context).size.width / 35,
//                       )))
//             ]),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Card(
//                 color: Colors.white70,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   " Daily Sales Report ",
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w400,
//                     fontSize: MediaQuery.of(context).size.width / 40,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//               height: MediaQuery.of(context).size.height * 0.74,
//               width: MediaQuery.of(context).size.width * 0.90,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.only(left: 20),
//                 child: SfCartesianChart(
//                   title: ChartTitle(text: "Daily Sales"),
//                   primaryXAxis:
//                       CategoryAxis(title: AxisTitle(text: "Sales Date")),
//                   primaryYAxis: NumericAxis(
//                       title: AxisTitle(
//                         text: "Sale in Rupees",
//                       ),
//                       labelFormat: "{value} Rs"),
//                   series: <ChartSeries>[
//                     ColumnSeries<Salesdata, String>(
//                         dataSource: Salesdata1,
//                         xValueMapper: (Salesdata sales, _) => sales.x,
//                         yValueMapper: (Salesdata sales, _) => sales.y,
//                         dataLabelSettings: DataLabelSettings(isVisible: true))
//                   ],
//                 ),
//               )),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Card(
//                 color: Colors.white70,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   " Live Sales Report ",
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w400,
//                     fontSize: MediaQuery.of(context).size.width / 40,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//               height: MediaQuery.of(context).size.height * 0.88,
//               width: MediaQuery.of(context).size.width * 0.90,
//               child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   margin: const EdgeInsets.only(left: 20),
//                   child: SfCartesianChart(
//                       primaryXAxis: CategoryAxis(),
//                       // Chart title
//                       title: ChartTitle(text: 'Live Sales'),
//                       // Enable legend
//                       //legend: Legend(isVisible: true),
//                       // Enable tooltip
//                       //tooltipBehavior: _tooltipBehavior,
//                       series: <LineSeries<SalesData, String>>[
//                         LineSeries<SalesData, String>(
//                             dataSource: Salesdata2,
//                             xValueMapper: (SalesData sales, _) => sales.year,
//                             yValueMapper: (SalesData sales, _) => sales.sale,
//                             // Enable data label
//                             dataLabelSettings:
//                                 const DataLabelSettings(isVisible: true))
//                       ]))),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Card(
//                 color: Colors.white70,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   " Hot Product ",
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w400,
//                     fontSize: MediaQuery.of(context).size.width / 40,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ) //),
//           )
//     ]));
//     //           ]))),
//     // ])));
//   }

//   // Get Store Sale data

//   Future<List<Salesdata>> getData() async {
//     var email = await Flutter_api().getEmail();
//     var storeId = await Flutter_api().generateStoreId(email);

//     // Getting Sales Data

//     var salesData = await Firestore.instance.collection(storeId).get();

//     for (var i in salesData) {
//       dataMap[i['saleDate']] = i['saleAmount'];
//     }

//     //salesData.sort();
//     // adding data but Aggregating Date to dailyDataMap
//     List<MapEntry<DateTime, int>> listMappedEntries = dataMap.entries.toList();

//     // Now will sort the list

//     listMappedEntries.sort((a, b) => a.key.compareTo(b.key));
//     final Map<DateTime, int> sortedMapData = Map.fromEntries(listMappedEntries);

//     //print(sortedMapData);
//     for (var i in sortedMapData.keys) {
//       if (dailyDataMap.containsKey(i.toString().split(" ")[0])) {
//         dailyDataMap[i.toString().split(" ")[0]] =
//             dailyDataMap[i.toString().split(" ")[0]]! + sortedMapData[i]!;
//       } else {
//         dailyDataMap[i.toString().split(" ")[0]] = sortedMapData[i]!;
//       }
//     }
//     //List<Salesdata> Salesdata1 = [];
//     setState(() {
//       for (var i in dailyDataMap.keys) {
//         Salesdata1.add(Salesdata(i.toString(), dailyDataMap[i]!));
//       }
//       for (var i in sortedMapData.keys) {
//         Salesdata2.add(
//             SalesData(DateFormat.yMd().add_Hm().format(i), sortedMapData[i]!));
//       }
//     });
//     return Future<List<Salesdata>>.value(Salesdata1);
//   }
// }

// class Salesdata {
//   String x;
//   int y;

//   Salesdata(this.x, this.y);
// }

// class SalesData {
//   String year;
//   int sale;

//   SalesData(this.year, this.sale);
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firedart/generated/google/firestore/v1/document.pb.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:d_chart/d_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'imports.dart';
import 'dart:convert';

class biCharts extends StatefulWidget {
  const biCharts({super.key});
  @override
  _biChartsState createState() => _biChartsState();
}

// TooltipBehavior _tooltipBehavior;

class _biChartsState extends State<biCharts> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var revenue = 0.0;
  var sale = 0.0;
  var orders = 0.0;
  String email = "";

  Map<DateTime, int> dataMap = {};
  Map<String, int> dailyDataMap = {};

  late List<Salesdata> Salesdata1 = [];
  late List<SalesData> Salesdata2 = [];
  late List<hotProduct> productCounter = [];

  @override
  void initState() {
    super.initState();
    getHotProduct();
    getData().then((value) => {
          setState(() {
            Salesdata1 = value;
          })
        });
  }

  // @override
  // void initState() {
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   super.initState();
  // }

  // final streamdata = FirebaseFirestore.instance
  //     .collection('65a763ce21e3932ef41844bfd6a48f79')
  //     .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      const Sidebar(),
      Expanded(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.015,
            ),
            child: Column(children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.057,
                  ),
                  child: Text("Report's",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width / 35,
                      )))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  " Daily Sales Report ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 40,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.74,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20),
                child: SfCartesianChart(
                  title: ChartTitle(text: "Daily Sales"),
                  primaryXAxis:
                      CategoryAxis(title: AxisTitle(text: "Sales Date")),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: "Sale in Rupees",
                      ),
                      labelFormat: "{value} Rs"),
                  series: <ChartSeries>[
                    ColumnSeries<Salesdata, String>(
                        dataSource: Salesdata1,
                        xValueMapper: (Salesdata sales, _) => sales.x,
                        yValueMapper: (Salesdata sales, _) => sales.y,
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  " Live Sales Report ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 40,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.88,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(left: 20),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Live Sales'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      //tooltipBehavior: _tooltipBehavior,
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            dataSource: Salesdata2,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sale,
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]))),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  " Hot Product ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 40,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.90,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 20),
                child: SfCartesianChart(
                  title: ChartTitle(text: "Hot Product"),
                  primaryXAxis:
                      CategoryAxis(title: AxisTitle(text: "Product Name")),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                        text: "Hot Product Quantity",
                      ),
                      labelFormat: "{value} Qty"),
                  series: <ChartSeries>[
                    ColumnSeries<hotProduct, String>(
                        dataSource: productCounter,
                        xValueMapper: (hotProduct sales, _) =>
                            sales.productName,
                        yValueMapper: (hotProduct sales, _) =>
                            sales.productCount,
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
              )),
        ],
      ))
    ]));
  }

  // Get Store Sale data

  Future<List<Salesdata>> getData() async {
    var email = await Flutter_api().getEmail();
    var storeId = await Flutter_api().generateStoreId(email);

    // Getting Sales Data

    var salesData = await Firestore.instance.collection(storeId).get();

    for (var i in salesData) {
      dataMap[i['saleDate']] = i['saleAmount'];
    }
    //salesData.sort();
    // adding data but Aggregating Date to dailyDataMap
    List<MapEntry<DateTime, int>> listMappedEntries = dataMap.entries.toList();

    // Now will sort the list

    listMappedEntries.sort((a, b) => a.key.compareTo(b.key));
    final Map<DateTime, int> sortedMapData = Map.fromEntries(listMappedEntries);

    print(sortedMapData);
    for (var i in sortedMapData.keys) {
      if (dailyDataMap.containsKey(i.toString().split(" ")[0])) {
        dailyDataMap[i.toString().split(" ")[0]] =
            dailyDataMap[i.toString().split(" ")[0]]! + sortedMapData[i]!;
      } else {
        dailyDataMap[i.toString().split(" ")[0]] = sortedMapData[i]!;
      }
    }
    //List<Salesdata> Salesdata1 = [];
    setState(() {
      for (var i in dailyDataMap.keys) {
        Salesdata1.add(Salesdata(i.toString(), dailyDataMap[i]!));
      }
      for (var i in sortedMapData.keys) {
        Salesdata2.add(
            SalesData(DateFormat.yMd().add_Hm().format(i), sortedMapData[i]!));
      }
    });
    return Future<List<Salesdata>>.value(Salesdata1);
  }

  Future<void> getHotProduct() async {
    var storeId =
        await Flutter_api().generateStoreId(await Flutter_api().getEmail());
    var stores = await Firestore.instance.collection(storeId).get();
    Map productCounter2 = {};
    for (var store in stores) {
      Map storeProduct = store["saleProducts"];
      for (var product in storeProduct.keys) {
        setState(() {
          if (productCounter2.containsKey(product)) {
            productCounter2[product] =
                productCounter2[product] + int.parse(storeProduct[product]);
          } else {
            productCounter2[product] = int.parse(storeProduct[product]);
          }
        });
      }
    }

    setState(() {
      productCounter2.forEach((key, value) {
        productCounter.add(hotProduct(key, value));
      });

      productCounter.sort((a, b) => b.productCount.compareTo(a.productCount));

      productCounter = productCounter.sublist(0, 6);
      productCounter = productCounter.sublist(0, 4);
    });
  }
}

class hotProduct {
  String productName;
  int productCount;

  hotProduct(this.productName, this.productCount);
}

class Salesdata {
  String x;
  int y;

  Salesdata(this.x, this.y);
}

class SalesData {
  String year;
  int sale;

  SalesData(this.year, this.sale);
}
