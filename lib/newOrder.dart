// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:quickalert/quickalert.dart';
import 'package:searchaholic/orderCard.dart';
import 'package:searchaholic/sidebar.dart';

import 'imports.dart';

class newOrder extends StatefulWidget {
  const newOrder({Key? key}) : super(key: key);
  @override
  _newOrderState createState() => _newOrderState();
}

class _newOrderState extends State<newOrder> {
  final products = [];
  final orderProducts = [];
  int totalBill = 0;

  @override
  void initState() {
    super.initState();
    totalBill = 0;

    products.clear();
    orderProducts.clear();

    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      const Sidebar(),
      Expanded(
        child: Column(
          children: [
            const Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "New Order",
                  style: TextStyle(
                    fontFamily: "NTR",
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ))),
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  // Left Side (Will be Basket)
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // Header of the Barket
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                // Basket Title + Icon
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: const [
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Basket",
                                        style: TextStyle(
                                          fontFamily: "NTR",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        // line on right side of the basket
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(60),
                                        ),
                                      ),
                                      // Clear Basket Button
                                      child: const Center(
                                        child: Text(
                                          "Clear Basket",
                                          style: TextStyle(
                                            fontFamily: "NTR",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Are you sure you want to clear the basket?
                                      QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.confirm,
                                          animType:
                                              QuickAlertAnimType.slideInRight,
                                          title: "Clear Basket",
                                          text:
                                              "Are you sure you want to clear the basket?",
                                          onConfirmBtnTap: () {
                                            setState(() {
                                              orderProducts.clear();
                                              totalBill = 0;
                                              for (var i = 0;
                                                  i < products.length;
                                                  i++) {
                                                products[i]['quantity'] = 1;
                                              }
                                            });
                                            Navigator.pop(context);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              color: const Color.fromARGB(255, 223, 223, 223),
                              height: MediaQuery.of(context).size.height,
                              // List View of the Basket
                              child: ListView.builder(
                                itemCount: orderProducts.length,
                                itemBuilder: (context, index) {
                                  return OrderCard(
                                    productName:
                                        orderProducts[index]['name'].toString(),
                                    productPrice: orderProducts[index]['price']
                                        .toString(),
                                    productQty: orderProducts[index]['quantity']
                                        .toString(),
                                    productID:
                                        orderProducts[index]['id'].toString(),
                                    buttonPress: () {},
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: const Center(
                                        child: Text(
                                          "TOTAL ",
                                          style: TextStyle(
                                            fontFamily: "NTR",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.blue,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "Rs. $totalBill",
                                            style: const TextStyle(
                                              fontFamily: "NTR",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      )),
                  // Right Side (Will be Products with Search Bar and Few Buttons)
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Container(
                            // Search Bar
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search Product",
                                hintStyle: const TextStyle(
                                  fontFamily: "NTR",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: searchQuery,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 35,
                            right: 30,
                          ),
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                // Making a Card for each Product
                                tileColor:
                                    const Color.fromRGBO(196, 229, 255, 1),
                                textColor: Colors.black,
                                title: Text(products[index]['name']),
                                subtitle:
                                    Text("Rs. ${products[index]['price']}"),
                                onTap: () {
                                  setState(() {
                                    if (orderProducts
                                        .contains(products[index])) {
                                      // Incrementing the Quantity of the Product
                                      print("Already in Basket");
                                      var i = orderProducts
                                          .indexOf(products[index]);
                                      //type of quanity
                                      print("lol");
                                      orderProducts[i]["quantity"] = (int.parse(
                                                  orderProducts[i]["quantity"]
                                                      .toString()) +
                                              1)
                                          .toString();
                                      totalBill += int.parse(
                                          products[index]['price'].toString());
                                      print(totalBill);
                                    } else {
                                      orderProducts.add(products[index]);
                                      totalBill += int.parse(
                                          products[index]['price'].toString());
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // Input User Email
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                left: 30,
                                right: 30,
                              ),
                              child: SizedBox(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "User Email",
                                    hintStyle: TextStyle(
                                        fontFamily: "NTR",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            // Confirm Button
                            Expanded(
                                child: SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Sending the Order to the Database
                                },
                                child: Text("Confirm"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }

  void buttonPress(productID) {
    // Removing the product from the list
  }

  void searchQuery(String query) {
    print(query);
    if (query.isNotEmpty) {
      var data = products.where((element) {
        var name = element['name'].toLowerCase();
        print(name);
        return name.contains(query.toLowerCase());
      }).toList();
      setState(() {
        orderProducts.add(data);
      });
    } else {
      return null;
    }
  }

  void submited(String query) {}

  Future getProducts() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];

    // Getting Documents from Firestore
    var data = await Firestore.instance
        .collection(email)
        .document("Product")
        .collection("products")
        .orderBy("productName", descending: false)
        .get();

    setState(() {
      products.clear();
      // adding Temp Data to the List
      data.forEach((element) {
        // spliting the Document ID to get the Product ID
        var data = {
          "id": element.id,
          "name": element['productName'],
          "price": element['productPrice'],
          "quantity": 1,
        };
        products.add(data);
      });
    });
    // Getting Documents from Firestore again the email
  }
}