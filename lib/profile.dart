import 'dart:convert';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:searchaholic/imports.dart';
import 'package:flutter/material.dart';
import 'package:searchaholic/sidebar.dart';

import 'editProduct.dart';
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
  dynamic address_l1;
  //dynamic password;

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

    setState(() {
      Store_name = data2['storeName'];
      Email = data2['email'];
      Phone_number = data2['phNo'];
      address_l1 = data2['storeLocation'];
      //password = data2['password'];
    });
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
        body: Form(
      child: Row(children: [
        Sidebar(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              ///Image with store name
              Container(
                child: Center(
                  child: Text('$Store_name',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: MediaQuery.of(context).size.width / 13,
                      )),
                ),
                height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/profile.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),

              ///store name
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.057),
                width: MediaQuery.of(context).size.width * 0.6,
                // Options [Public or Private]
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: Color.fromARGB(255, 92, 154, 241))),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Text(
                      "  Store Name :             $Store_name",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 50,
                      ),
                    )),
              ),

              ///Phone Number
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.057),
                width: MediaQuery.of(context).size.width * 0.6,
                // Options [Public or Private]
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: Color.fromARGB(255, 92, 154, 241))),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Text(
                      "  Phone No :                $Phone_number",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 50,
                      ),
                    )),
              ),

              ///Address
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.057),
                width: MediaQuery.of(context).size.width * 0.6,
                // Options [Public or Private]
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: Color.fromARGB(255, 92, 154, 241))),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Text(
                      "  Address :    $address_l1",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 50,
                      ),
                    )),
              ),

              ///Email
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.057),
                width: MediaQuery.of(context).size.width * 0.6,
                // Options [Public or Private]
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: Color.fromARGB(255, 92, 154, 241))),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Text(
                      "  Email :                        $Email",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 50,
                      ),
                    )),
              ),

              ///Edit Button
              // Container(
              //   margin: EdgeInsets.only(
              //       top: MediaQuery.of(context).size.height * 0.057),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // print value is updated
              //       print("Profile Updated");
              //       /*Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => EditProduct(
              //                   email: '',
              //                   productID: '',
              //                 )),
              //       );*/
              //     },
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.blue,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10)),
              //     ),
              //     child: const Text("Update",
              //         style: TextStyle(color: Colors.white)),
              //   ),
              // ),
            ]),
          ),
        ),
      ]),
    ));
    //]));
  }
}
