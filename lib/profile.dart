import 'dart:convert';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:searchaholic/imports.dart';
import 'package:flutter/material.dart';
import 'package:searchaholic/sidebar.dart';
//import 'package:searchaholic/textBox.dart';

class profile extends StatefulWidget {
  const profile({
    Key? key,
  }) : super(key: key);
  //const profile({super.key});
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  dynamic Store_name;
  dynamic Email;
  dynamic Phone_number;
  dynamic address_l1, address_l2;

  ///getting profile data from databae
  Future getprofile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];

    // Getting Documents from Firestore
    var data = Firestore.instance.collection(email);
    var data1 = data.document('Store Details');
    var data2 = await data1.get();

    Store_name = data2['storeName'];
    Email = data2['email'];
    Phone_number = data2['phNo'];
    address_l1 = data2['lat'];
    address_l2 = data2['long'];
    print(address_l1);
    print(Store_name);
  }

  @override
// Update State
  void initState() {
    getprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Sidebar(),
        Expanded(
          child: Container(
            child: Column(children: [
              ///image of store with name
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.087,
                ),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: Image.asset(
                      'images/password_recover.jpg'), //this is a dumy image
                ),
              ),

              ///shows Store Name
              Padding(
                padding: EdgeInsets.only(
                  //left: MediaQuery.of(context).size.height,
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: 250,
                      maxHeight: 120),
                  //minHeight: 100),
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0))),
                      child: Text(
                        "Store Name : $Store_name",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 60,
                        ),
                      )),
                ),
              ),

              ///show store address
              Padding(
                padding: EdgeInsets.only(
                  //left: MediaQuery.of(context).size.height,
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: 250,
                      maxHeight: 120),
                  //minHeight: 100),
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0))),
                      child: Text(
                        "Address : $address_l1," + "$address_l2",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 60,
                        ),
                      )),
                ),
              ),

              ///show Phone Number
              Padding(
                padding: EdgeInsets.only(
                  //left: MediaQuery.of(context).size.height,
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: 250,
                      maxHeight: 120),
                  //minHeight: 100),
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0))),
                      child: Text(
                        "Phone No : $Phone_number",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 60,
                        ),
                      )),
                ),
              ),

              ///show Email address
              Padding(
                padding: EdgeInsets.only(
                  //left: MediaQuery.of(context).size.height,
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: 250,
                      maxHeight: 120),
                  //minHeight: 100),
                  child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0))),
                      child: Text(
                        "Email : $Email",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 60,
                        ),
                      )),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
    //]));
  }
}
