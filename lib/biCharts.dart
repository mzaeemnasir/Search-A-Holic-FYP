import 'package:firedart/generated/google/firestore/v1/document.pb.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'imports.dart';

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

  // @override
  // void initState() {
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: formkey,
            child: Row(children: [
              Sidebar(),
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
                          child: Text("Report's",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width / 45,
                              )),
                        ),

                        ///Today's report
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Generate Report's",
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
                            height: MediaQuery.of(context).size.width * 0.10,
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
                                      top: MediaQuery.of(context).size.width *
                                          0.01,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                      left: MediaQuery.of(context).size.width *
                                          0.01,
                                      right: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      color: Colors.grey[100],
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                                    "Hot Products",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              80,
                                                    ),
                                                  )
                                                ],
                                              ),

                                              ///Padding
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.015,
                                              ),

                                              ///Icon
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.007,
                                                    bottom:
                                                        MediaQuery.of(context)
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
                                      top: MediaQuery.of(context).size.width *
                                          0.01,
                                      left: MediaQuery.of(context).size.width *
                                          0.075,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                      right: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      color: Colors.grey[100],
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                                    "Season Trend",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              80,
                                                    ),
                                                  )
                                                ],
                                              ),

                                              ///Padding
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.015,
                                              ),

                                              ///Icon
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.007,
                                                    bottom:
                                                        MediaQuery.of(context)
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
                                      top: MediaQuery.of(context).size.width *
                                          0.01,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                      left: MediaQuery.of(context).size.width *
                                          0.057,
                                      right: MediaQuery.of(context).size.width *
                                          0.0009,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      color: Colors.grey[100],
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                                    "Trend",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              55,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   "Rs. " + orders.toString(),
                                                  //   style: TextStyle(
                                                  //     color: Colors.black,
                                                  //     fontFamily: "Montserrat",
                                                  //     fontWeight:
                                                  //         FontWeight.w300,
                                                  //     fontSize:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .width /
                                                  //             80,
                                                  //   ),
                                                  // )
                                                ],
                                              ),

                                              ///Padding
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.015,
                                              ),

                                              ///Icon
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.007,
                                                    bottom:
                                                        MediaQuery.of(context)
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sales Report",
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: MediaQuery.of(context).size.width / 45,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              // top: MediaQuery.of(context).size.height * 0.015,
                              // bottom: MediaQuery.of(context).size.height * 0.02,
                              ),
                          child: SizedBox(
                              // height: MediaQuery.of(context).size.width * 0.25,
                              // width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                height:
                                    MediaQuery.of(context).size.height * 0.48,
                                width: MediaQuery.of(context).size.width * 0.31,
                                child: SfCartesianChart(
                                  title: ChartTitle(text: "Daily Sales"),
                                  primaryXAxis: CategoryAxis(
                                      title: AxisTitle(text: "Sales Date")),
                                  primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                        text: "Sale in Lack's",
                                      ),
                                      labelFormat: "{value} lac"),
                                  series: <ChartSeries>[
                                    ColumnSeries<Salesdata, String>(
                                        dataSource: getSalesdata(),
                                        xValueMapper: (Salesdata sales, _) =>
                                            sales.x,
                                        yValueMapper: (Salesdata sales, _) =>
                                            sales.y,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true))
                                  ],
                                ),
                              ),
                              // your blue container
                              Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  height:
                                      MediaQuery.of(context).size.height * 0.48,
                                  width:
                                      MediaQuery.of(context).size.width * 0.31,
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      // Chart title
                                      title: ChartTitle(
                                          text: 'Half yearly sales analysis'),
                                      // Enable legend
                                      //legend: Legend(isVisible: true),
                                      // Enable tooltip
                                      //tooltipBehavior: _tooltipBehavior,
                                      series: <LineSeries<SalesData, String>>[
                                        LineSeries<SalesData, String>(
                                            dataSource: <SalesData>[
                                              SalesData('Jan', 23),
                                              SalesData('Feb', 28),
                                              SalesData('Mar', 34),
                                              SalesData('Apr', 32),
                                              SalesData('May', 40)
                                            ],
                                            xValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.year,
                                            yValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.sales,
                                            // Enable data label
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true))
                                      ])),
                            ],
                          )),
                        )
                      ]))),
            ])));
  }
}

class Salesdata {
  String x;
  double y;

  Salesdata(this.x, this.y);
}

dynamic getSalesdata() {
  List<Salesdata> Salesdata1 = <Salesdata>[
    Salesdata("25", 3.4),
    Salesdata("26", 5.6),
    Salesdata("27", 3.4),
    Salesdata("28", 6),
    Salesdata("29", 2),
    Salesdata("30", 7.6)
  ];
  return Salesdata1;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
