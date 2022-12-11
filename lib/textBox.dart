// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Expanded textBox(
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
        height: MediaQuery.of(context).size.height * 0.19,
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
                          child: Image(
                            image: logo,
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                        )
                      : Container(),
                ),
                Container(
                  child: Align(
                    alignment: Alignment
                        .bottomCenter, //.center : Alignment.bottomLeft,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "NTR",
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width / textSize,
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
  );
}
