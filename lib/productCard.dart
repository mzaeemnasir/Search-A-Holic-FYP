import 'dart:async';

import 'package:flutter/material.dart';
import 'package:searchaholic/imports.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Map<String, dynamic> product;
  // // Products has elements
  //   {
  //         "name": "Product 1",
  //         "price": "100",
  //         "quantity": "10",
  //         "description": "Product 1 Description"
  //       },

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.02,
        ),
        shadowColor: Colors.grey[50],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[50],
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.075,
              child: SizedBox(
                child: Text(
                  product['name'],
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 75,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              transformAlignment: Alignment.center,
              alignment: Alignment.center,
              child: const Text(
                "# 1231231",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 74, 135, 249),
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              transformAlignment: Alignment.center,
              alignment: Alignment.center,
              child: const Text(
                "Quantity: 10",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 74, 135, 249),
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              transformAlignment: Alignment.center,
              alignment: Alignment.center,
              child: const Text(
                "Rs. 500",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 231, 79, 87),
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Card(
                color: Color.fromARGB(255, 74, 135, 249),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.03,
                  height: MediaQuery.of(context).size.height * 0.03,
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      print("Edit Button Pressed");
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: MediaQuery.of(context).size.width / 110,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Card(
                color: Color.fromARGB(255, 255, 125, 125),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.04,
                  height: MediaQuery.of(context).size.height * 0.03,
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      print("Delete Button Pressed");
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: MediaQuery.of(context).size.width / 110,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
