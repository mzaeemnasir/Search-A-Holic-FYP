import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  String productName = "";
  String productPrice = "";
  String productQty = "";
  String productID = "";
  OrderCard(
      {Key? key,
      required this.productName,
      required this.productPrice,
      required this.productQty,
      required this.productID,
      required Null Function() buttonPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Card(
          shadowColor: Colors.grey[50],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey[50],
          child: Row(
            children: [
              Expanded(
                  child: SizedBox(
                      height: 45, child: Align(child: Text(productName)))),
              Expanded(
                  child: SizedBox(
                      height: 45,
                      child: Align(
                          child: Text("Rs. $productPrice",
                              style: TextStyle(color: Colors.red))))),
              Expanded(
                  child: SizedBox(
                      height: 45,
                      child: Align(
                          child: Text("Qty. $productQty",
                              style: TextStyle(color: Colors.blue))))),
              Expanded(
                  child: SizedBox(
                      height: 45,
                      child: InkWell(
                          hoverColor: Colors.red,
                          child: const Align(child: Text("Delete")),
                          onTap: () {
                            // Remove product from orderProducts List
                          }))),
            ],
          ),
        ));
  }
}
