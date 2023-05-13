// ignore_for_file: camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, depend_on_referenced_packages

import 'package:firedart/firedart.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:searchaholic/orderCard.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:share_whatsapp/share_whatsapp.dart';
import 'imports.dart';

final selectedProducts = [];

class newOrder extends StatefulWidget {
  const newOrder({Key? key}) : super(key: key);
  @override
  _newOrderState createState() => _newOrderState();
}

class _newOrderState extends State<newOrder> {
  final products = [];

  final searchProducts = [];
  int totalBill = 0;
  final quantityController = TextEditingController();
  final _emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  dynamic Store_name;
  dynamic Email;
  dynamic Phone_number;
  dynamic address_l1, address_l2;
  dynamic date;
  dynamic msg;
  //dynamic password;

  ///getting profile data from databae
  Future getprofile() async {
    String email = await Flutter_api().getEmail();

    // Getting Documents from Firestore
    var data = Firestore.instance.collection(email);
    var data1 = data.document('Store Details');
    var data2 = await data1.get();

    late String full_address;

    setState(() {
      Store_name = data2['storeName'];
      Email = data2['email'];
      Phone_number = data2['phNo'];
      address_l1 = data2['storeLocation'].latitude;
      address_l2 = data2['storeLocation'].longitude;
    });
  }

  Future getDateandTime() async {
    var now = DateTime.now();
    var formatter = DateFormat.yMMMMd().add_jm();
    String formattedDate = formatter.format(now);
    setState(() {
      date = formattedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    totalBill = 0;
    products.clear();
    searchProducts.clear();
    getProducts().then((value) => {
          print("Products Fetched"),
        });
    getprofile();
  }

  //-------------------------- Indexes of the Product --------------------------
  final Name = "Name";
  final Price = "Price";
  final Quantity = "Quantity";
  final Category = "Category";
  final Expire = "Expire";
  final StoreId = "StoreId";
  final ProductId = "ProductId";
  final StoreName = "StoreName";
  final Type = "Type";
  final StoreLocation = "StoreLocation";

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              children: [
                // Header of the Page New Order
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
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      // Basket Title + Icon
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: const [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                      SizedBox(
                                        width: 120,
                                        // Clear Basket Button
                                        child: Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                                onPressed: () {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.confirm,
                                                    animType: QuickAlertAnimType
                                                        .slideInRight,
                                                    title: "Clear Basket",
                                                    text:
                                                        "Are you sure you want to clear the basket?",
                                                    onConfirmBtnTap: () {
                                                      setState(() {
                                                        selectedProducts
                                                            .clear();
                                                        totalBill = 0;
                                                        searchProducts.clear();
                                                        getProducts();
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  "Clear Basket",
                                                  style: TextStyle(
                                                    fontFamily: "NTR",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                )),
                            // List View of the Basket
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                //padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey[200],
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  // List View of the Basket
                                  child: ListView.builder(
                                    itemCount: selectedProducts.length,
                                    itemBuilder: (context, index) {
                                      print(selectedProducts[index]);
                                      return GestureDetector(
                                        onTap: () => {
                                          setState(
                                            () => {
                                              // Updating the Total Bill
                                              totalBill = totalBill -
                                                  (double.parse(
                                                              selectedProducts[
                                                                          index]
                                                                      [Price]
                                                                  .toString())
                                                          .toInt() *
                                                      int.parse(
                                                          selectedProducts[
                                                                      index]
                                                                  [Quantity]
                                                              .toString())),

                                              // int.parse(selectedProducts[index]
                                              //         [Quantity]
                                              //     .toString()) ,

                                              searchProducts.forEach(
                                                (element) {
                                                  if (element[Name] ==
                                                      selectedProducts[index]
                                                          [Name]) {
                                                    element[
                                                        Quantity] = double.parse(
                                                                selectedProducts[
                                                                        index]
                                                                    [Quantity])
                                                            .toInt() +
                                                        int.parse(
                                                            element[Quantity]
                                                                .toString());
                                                  }
                                                },
                                              ),
                                              // Removing the Product from the Basket
                                              selectedProducts.removeAt(index),
                                            },
                                          ),
                                        },
                                        child: OrderCard(
                                          productName: selectedProducts[index]
                                                  [Name]
                                              .toString(),
                                          productPrice: double.parse(
                                              selectedProducts[index][Price]
                                                  .toString()),
                                          productQty: double.parse(
                                              selectedProducts[index][Quantity]
                                                  .toString()),
                                          productID: selectedProducts[index]
                                                  [ProductId]
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20))),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
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
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20))),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
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
                                  ),
                                ))
                          ],
                        ),
                      ),
                      // Right Side (Will be Products with Search Bar and Few Buttons)
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                  top: 20,
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      contentPadding: EdgeInsets.only()),
                                  onChanged: searchQuery,
                                ),
                              ),
                            ),

                            // List View of the Search Products
                            Flexible(
                              flex: 55,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 35,
                                  right: 30,
                                  bottom: 20,
                                ),
                                child: SizedBox(
                                  child: ListView.builder(
                                    itemCount: searchProducts.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Card(
                                          elevation: 2,
                                          color: Colors.blue[300],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            // Making a Card for each Product
                                            title: Text(
                                              searchProducts[index][Name],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "Rs. ${searchProducts[index][Price]}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing: Text(
                                              "Qty: ${searchProducts[index][Quantity]}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                Iterable productDetails =
                                                    searchProducts.where(
                                                        (element) =>
                                                            element[Name] ==
                                                            searchProducts[
                                                                index][Name]);
                                                OpenDialoge(
                                                    searchProducts[index]
                                                        [ProductId],
                                                    productDetails.toList()[0]);
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Row(
                                  children: [
                                    // Input User Email
                                    Flexible(
                                      child: Form(
                                        key: formkey,
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: _emailController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Phone number required';
                                            } else {
                                              RegExp regExp = RegExp(
                                                r"^[0-9]{11}$",
                                                caseSensitive: false,
                                                multiLine: false,
                                              );
                                              if (!regExp.hasMatch(value)) {
                                                // Make input field red
                                                return 'Please enter a valid phone number';
                                              }
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Phone Number",
                                              hintStyle: const TextStyle(
                                                fontFamily: "NTR",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                              ),
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 10),
                                                child: Icon(Icons.phone),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only()),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // Confirm Button
                                    SizedBox(
                                      height: 43,
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            // INVOICE
                                            getDateandTime();

                                            QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.warning,
                                                title:
                                                    'Prescription Confirmation',
                                                text:
                                                    'Have you checked the prescription?',
                                                onConfirmBtnTap: () => {
                                                      Navigator.pop(context),
                                                      invoiceDiagloge(),
                                                    });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          // ignore: deprecated_member_use
                                          primary: Colors.blue,
                                          // ignore: deprecated_member_use
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text("Checkout"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Invoice Dialoge
  Future invoiceDiagloge() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(left: 150),
            child: Text(
              "$Store_name",
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          //Text("Invoice - ${_emailController.text}"),
          content: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text("Sales Invoice",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 280),
                child: Text("Address: $address_l1,$address_l2",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 235),
                child: Text("Tel #: $Phone_number",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Text("Date & Time: $date",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 175),
                child: Text("Customer Tel #: ${_emailController.text}",
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
              ),
              const Divider(
                thickness: 2,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Scrollbar(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: selectedProducts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == selectedProducts.length) {
                        return ListTile(
                          title: const Text("Total Bill"),
                          trailing: Text("Rs. $totalBill"),
                          // Total Bill
                        );
                      } else {
                        var price = "${selectedProducts[index][Price]}";
                        var quantity = "${selectedProducts[index][Quantity]}";

                        return ListTile(
                          title: Text(selectedProducts[index][Name]),
                          subtitle: Text(
                              "Rs. ${selectedProducts[index][Price]} x ${selectedProducts[index][Quantity]}"),
                          // ignore: unnecessary_new
                          trailing: new Text(
                              "Rs. ${int.parse(price) * int.parse(quantity)}"),
                          // Total Bill
                        );
                      }
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: Text(
                    'Total discount',
                  ),
                  trailing: Text('0'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: Text(
                    'Sales Tax %',
                  ),
                  trailing: Text('0'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 05),
                child: ListTile(
                  dense: true,
                  title: const Text(
                    'Total Amount',
                  ),
                  trailing: Text('$totalBill'),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Thank You for choosing $Store_name",
                    style: const TextStyle(fontSize: 11, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("For feedback @ $Email",
                    style: const TextStyle(fontSize: 11, color: Colors.black)),
              ),

              // Add more Text widgets for additional lines of data
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, // Adding Product
                    MaterialPageRoute(builder: (context) => const newOrder()));
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // await createSales();
                msg =
                    "$Store_name\nSales Invoice\nAddress: $address_l1,$address_l2\nTel #: $Phone_number\nDate & Time: $date\nCustomer Tel #: ${_emailController.text}\n${selectedProducts[0]['name']}  Rs. ${selectedProducts[0]['price']} x ${selectedProducts[0]['quantity']}\nSales Tax:0\nDiscount:0\nTotal Amount:$totalBill\nThank You for choosing $Store_name\nFor feedback @ $Email\n";
                if (await updateProductsQuantity()) {
                  print("Products Quantity Updated Successfully");
                }
                shareWhatsapp.share(
                  text: msg,
                  // change with real whatsapp number
                  phone: '+92${_emailController.text}',
                );
                // ignore: unused_local_variable

                Navigator.pop(context);
                if (await Flutter_api().addOrder(selectedProducts, totalBill) ==
                    true) {
                  setState(() {
                    selectedProducts.clear();
                    totalBill = 0;
                  });
                }
                Navigator.push(
                    context, // Adding Product
                    MaterialPageRoute(builder: (context) => const newOrder()));

                // Adding the Invoice to the Database
                // Updating the Products Quantity
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      );

  Future OpenDialoge(productID, productDetails) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Product Quantity?"),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Quantity",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onChanged: ((value) => {
                  if (value.isNotEmpty)
                    {
                      if (int.parse(value) >
                          int.parse(productDetails[Quantity].toString()))
                        {
                          setState(() {
                            quantityController.text = productDetails[Quantity];
                          })
                        }
                    }
                }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Do Nothing....
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                var index = products
                    .indexWhere((element) => element[ProductId] == productID);

                if (quantityController.text.isNotEmpty) {
                  if (selectedProducts.contains(products[index])) {
                    setState(() {
                      // Checking if the quantity is greater than the available quantity
                      if (int.parse(quantityController.text) >
                          int.parse(products[index][Quantity].toString())) {
                        // Alert Dialoge to show the error
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "The quantity you entered is greater than the available quantity"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      // Updating the quantity of the product
                      var Qty = double.parse(quantityController.text);
                      var qty = double.parse(
                          selectedProducts[index][Quantity].toString());
                      var price = double.parse(
                          selectedProducts[index][Price].toString());
                      totalBill += int.parse((price * Qty).toString());

                      selectedProducts[index][Quantity] = int.parse(
                          (Qty + qty).toString()); // Updating the quantity
                    });
                  } else {
                    setState(() {
                      // Checking if the quantity is greater than the available quantity
                      if (int.parse(quantityController.text) >
                          int.parse(products[index][Quantity].toString())) {
                        // Alert Dialoge to show the error
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "The quantity you entered is greater than the available quantity"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      int controlerQty =
                          int.parse((quantityController.text).toString());
                      int productQty =
                          int.parse((products[index][Quantity]).toString());

                      var x = products.elementAt(index);

                      selectedProducts.add({
                        "Name": x[Name],
                        "Price": x[Price],
                        "Quantity": quantityController.text,
                        "ProductId": x[ProductId],
                        "Category": x[Category],
                        "Type": x[Type],
                        "StoreId": x[StoreId],
                        "Expire": x[Expire],
                      });

                      int selIndex = selectedProducts.indexWhere(
                          (element) => element[ProductId] == productID);

                      int productPrice = double.parse(
                              selectedProducts[selIndex][Price].toString())
                          .round()
                          .toInt();

                      products[index][Quantity] = (productQty - controlerQty)
                          .toString(); // Updating the quantity

                      totalBill += (controlerQty * productPrice);
                      print("Total Bill: $totalBill");
                    });
                  }
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      );

  // Record Sales

  void recordSales() {
    // Structure
    // Sales -> StoreId -> SalesId -> Sales Details

    var email = Flutter_api().getEmail();
    var storeId = Flutter_api().generateStoreId(email);

    // Getting the Current Date and Time
    var now = DateTime.now(); // yyyy-MM-dd hh:mm:ss
    var date = DateFormat('yyyy-MM-dd').format(now);
    var time = DateFormat('hh:mm:ss').format(now);

    // Generating the Sales Id with the Date and Time
    var salesId = Flutter_api().generateStoreId(now.toString());
  }

  void searchQuery(String query) {
    if (query.isNotEmpty) {
      var data = products.where((element) {
        var productName = element[Name].toLowerCase();
        return productName.contains(query.toLowerCase());
      }).toList();
      setState(() {
        searchProducts.clear();
        searchProducts.addAll(data);
      });
    } else {
      setState(() {
        // Clearing the search list
        searchProducts.clear();
        searchProducts.addAll(products);
      });
    }
  }

  // Creating Sales of the Products
  Future createSales() async {
    // Creating Sales
    String phoneNumber = _emailController.text;

    // List of Products only Names
    List porductNames = [];
    for (var i = 0; i < selectedProducts.length; i++) {
      porductNames.add(selectedProducts[i][Name]);
    }

    var email = await Flutter_api().getEmail();

    // Creating a Unique Invoice ID for the Invoice with Timestamp
    var invoiceID = DateTime.now().millisecondsSinceEpoch.toString();

    // Updating the Products Quantity
    // await Firestore.instance
    //     .collection(email)
    //     .document("Sales")
    //     .collection(phoneNumber)
    //     .add({
    //   "Name": p[Name],
    //   "Price": p[Price],
    //   "Quantity": p[Quantity],
    //   "Category": p[Category],
    //   "Expire": p[Expire],
    //   "ProductId": p[ProductId],
    //   "PhoneNumber": phoneNumber,
    //   "Date": DateTime.now().toString(),
    //   "TotalBill": totalBill,
    //   "InvoiceID": invoiceID,
    // });
  }

  // Updating the Products Quantity
  Future updateProductsQuantity() async {
    for (var i = 0; i < selectedProducts.length; i++) {
      var proIndex = products.indexWhere(
          (element) => element[ProductId] == selectedProducts[i][ProductId]);

      var p = selectedProducts[i];
      var productID = p[ProductId];
      var productQty =
          int.parse(products[proIndex][Quantity]) - int.parse(p[Quantity]);

      var tempProducts = await Firestore.instance
          .collection("Products")
          .document(p[StoreId])
          .get();

      var map = updateQtyMap(tempProducts.map);

      await Firestore.instance
          .collection("Products")
          .document(p[StoreId])
          .set(map);

      return Future.value(true);
    }
  }

  Map<String, dynamic> updateQtyMap(Map<String, dynamic> map) {
    for (var i = 0; i < selectedProducts.length; i++) {
      var p = selectedProducts[i];
      var productID = p[ProductId];
      var productQty = int.parse(p[Quantity]);

      map.update(
          productID,
          (value) => {
                "Name": value[Name],
                "Price": value[Price],
                "Quantity":
                    (int.parse(value[Quantity].toString()) - productQty),
                "Category": value[Category],
                "Expire": value[Expire],
                "ProductId": value[ProductId],
                "StoreId": value[StoreId],
                "Type": value[Type],
                "Expire": value[Expire],
                "ProductId": value[ProductId],
              });
      // (int.parse(map[productID][Quantity]) - productQty).toString();
    }

    return map;
  }

  Future getProducts() async {
    String email = await Flutter_api().getEmail();
    String storeId = Flutter_api().generateStoreId(email);

    // Getting Documents from Firestore
    var data =
        await Firestore.instance.collection("Products").document(storeId).get();

    setState(() {
      products.clear();
      data.map.forEach((key, value) {
        searchProducts.add(value);
        products.add(value);
      });
    });
  }
}
