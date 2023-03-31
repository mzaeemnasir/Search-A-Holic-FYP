// ignore_for_file: unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace

import 'dart:convert';

import 'package:firedart/firestore/firestore.dart';
import 'package:searchaholic/editProduct.dart';
import 'package:searchaholic/imports.dart';
import 'package:searchaholic/product.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product}) : super(key: key);
  final product;
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
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                top: MediaQuery.of(context).size.height * 0.12,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  product['Name'],
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 80,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06)),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  transformAlignment: Alignment.center,
                  alignment: Alignment.center,
                  child: Text(
                    'Qty: ' + product['Quantity'].toString(),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Color.fromARGB(255, 74, 135, 249),
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    ),
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                transformAlignment: Alignment.center,
                alignment: Alignment.center,
                child: Text(
                  "Rs. ${product['Price']}",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Color.fromARGB(255, 231, 79, 87),
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                width: MediaQuery.of(context).size.width,
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
                        navigate(context, product["id"]);
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
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
                        // Delete product
                        var productID = product["id"];
                        // Are you sure?
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Are you sure?"),
                              content: Text("This action cannot be undone."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Delete product
                                    if (await deleteProduct(productID) ==
                                        true) {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Product deleted, "),
                                        ),
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Product()));
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
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
            ),
          ],
        ),
      ),
    );
  }

  void navigate(context, productID) {
    print("Navigating to edit product page...");
    getEmail().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProduct(
            productID: productID,
            email: value,
          ),
        ),
      );
    });
  }

  Future<String> getEmail() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];

    return Future<String>.value(email);
  }

  Map<String, dynamic> removeMapData(Map<String, dynamic> map, String id) {
    map.remove(id);
    map.forEach((key, value) {
      if (key == id) {
        print("Found the key to be deleted");
        map.remove(key);
      }
    });
    return map;
  }

  Future<bool> deleteProduct(String id) async {
    print(id);

    String email = await Flutter_api().getEmail();
    var x = Flutter_api().generateStoreId(email);

    // Deleting the Product from Firestore
    try {
      final DATA =
          await Firestore.instance.collection("Products").document(x).get();

      final map = removeMapData(DATA.map, id);

      await Firestore.instance.collection("Products").document(x).set(map);

      print("Product Deleted");
      print(DATA.map);
      // Reload the content of the list in the previous page
      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }
}
