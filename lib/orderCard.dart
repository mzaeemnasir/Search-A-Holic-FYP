import 'package:flutter/material.dart';
import 'package:searchaholic/newOrder.dart';

class OrderCard extends StatelessWidget {
  String productName = "";
  double productPrice = 0;
  double productQty = 0;
  String productID = "";

  OrderCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productQty,
    required this.productID,
  }) : super(key: key);

  // buttonPress

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
                              style: const TextStyle(color: Colors.red))))),
              Expanded(
                  child: SizedBox(
                      height: 45,
                      child: Align(
                          child: Text("Qty. $productQty",
                              style: const TextStyle(color: Colors.blue))))),
              const Expanded(
                  child: SizedBox(
                      height: 45,
                      // Delete Icon
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Align(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ))),
            ],
          ),
        ));
  }
}
