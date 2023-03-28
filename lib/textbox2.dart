// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:searchaholic/newOrder.dart';
import 'package:searchaholic/product.dart';
import 'addProduct.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

Expanded textbox2(
  BuildContext context,
  String text,
  Color topRightColor,
  Color topLeftColor,
  AssetImage logo,

  ///Optional parameters
  [
  bool centerText = false,
  int textSize = 55,
]) {
  return Expanded(
    child: Material(
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: InkWell(
          // onTap: () {
          //   print(text);
          //   if (text == "Add Product") {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const AddProduct()));
          //   }
          //   if (text == "Search Product") {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const Product()));
          //   }
          //   if (text == "New Order") {
          //     Navigator.pushReplacement(
          //         context, MaterialPageRoute(builder: (context) => newOrder()));
          //   }
          // },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [topRightColor, topLeftColor],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.023,
              ),
              // Adding Logo
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: logo != ""
                        ? Center(
                            child: SizedBox(
                              width: 100,
                              child: SimpleCircularProgressBar(
                                // valueNotifier: valueNotifier,
                                mergeMode: true,
                                onGetText: (double value) {
                                  return Text(
                                    '01',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 05),
                    child: Container(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "NTR",
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize:
                              MediaQuery.of(context).size.width / textSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
