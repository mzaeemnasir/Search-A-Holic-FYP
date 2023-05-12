// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'imports.dart';
import 'orderCard.dart';

// Invoice Class
class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left part contains the item inside the order
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /// Page title
              Text(
                "Your Invoice",
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600),
              ),

              /// Divider
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 2.5,
                  color: Colors.black,
                ),
              ),

              /// Items list
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InvoiceItem(
                        productName: "Product name",
                        productPrice: "20 dr",
                        productQty: "30",
                        productID: "12345");
                  },
                ),
              )
            ]),
          ),

          /// Right part contains customer information
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Column title
                  Text(
                    "Billing information:",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),

                  /// Divider
                  Divider(
                    color: Colors.white,
                    thickness: 0.5,
                  ),

                  /// Name
                  invoiceInformations("Name:", "Customer name"),

                  /// Address
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: invoiceInformations("Address: ", "Customer address"),
                  ),

                  /// Phone number
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:
                        invoiceInformations("Phone number: ", "+ 00 123456789"),
                  ),

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TextButton(
                          /// TODO: redirects the user to another page closing
                          /// the invoice
                          onPressed: () {},

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "CLOSE",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.blue[600],
                              elevation: 5),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// This function returns a column which contains two text labels. It is used
/// in the right part of the screen to display the customer information
Column invoiceInformations(String title, String info) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 20,
            letterSpacing: 1,
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),
      Text(
        info,
        style: TextStyle(
            fontSize: 15,
            letterSpacing: 1,
            color: Colors.white,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}

/// A modified instance of "orderCard", without the "delete" button
class InvoiceItem extends StatelessWidget {
  String productName = "";
  String productPrice = "";
  String productQty = "";
  String productID = "";

  InvoiceItem({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productQty,
    required this.productID,
  }) : super(key: key);

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
            ],
          ),
        ));
  }
}
