import 'dart:convert';

import 'package:alert/alert.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/services.dart';
import 'package:searchaholic/firebase_.dart';
import 'package:searchaholic/imports.dart';
import 'package:quickalert/quickalert.dart';
import 'package:email_otp/email_otp.dart';

class change extends StatefulWidget {
  const change({super.key});

  @override
  _changeState createState() => _changeState();
}

class _changeState extends State<change> {
  bool otpst = false;
  //var _email = TextEditingController();
  //var storeName = TextEditingController();
  //var storeLocationLat = TextEditingController();
  //var storeLocationLong = TextEditingController();
  //var phoneNumber = TextEditingController();
  var _password = TextEditingController();
  var _newPassword = TextEditingController();
  var _confirmPassword = TextEditingController();
  var otp = TextEditingController();

  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'password is wrong',
    );
  }

  void showAlert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'New password not match with confirm password',
    );
  }

  void showAlert2() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Yahoooo...',
      text: 'Password changed successfully!!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white,
            child: Expanded(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.116,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Confirm Credentials",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Text Field Email

                    // Password (with eye icon)
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        obscureText: _isObscure,
                        maxLength: 18,
                        // validation
                        controller: _password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid password';
                            }
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          hintText: "Password",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey[450],
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 0.15),
                          ),
                        ),
                      ),
                    ),

                    // New Password (with eye icon)
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        obscureText: _isObscure1,
                        maxLength: 18,
                        // validation
                        controller: _newPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid password';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure1
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure1 = !_isObscure1;
                                });
                              }),
                          hintText: "New Password",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey[450],
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 0.15),
                          ),
                        ),
                      ),
                    ),

                    /// Confirm Password (with eye icon)
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        obscureText: _isObscure2,
                        maxLength: 18,
                        // validation
                        controller: _confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid password';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              }),
                          hintText: "Confirm Password",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey[450],
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 0.15),
                          ),
                        ),
                      ),
                    ),

                    // Register Button
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.055,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (await password_check(_password.text) == true) {
                              showAlert();
                            } else if (newpassword_match(
                                    _newPassword.text, _confirmPassword.text) ==
                                true) {
                              showAlert1();
                            } else {
                              change(_confirmPassword.text);
                              showAlert2();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(53, 108, 254, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Change Password",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    // LOGIN INSTEAD Button
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.025,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(53, 108, 254, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Back",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right Side
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: const Color.fromRGBO(8, 92, 228, 1),
            child: Expanded(
              child: Column(
                children: [
                  // Txt Field
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      "Change Password",
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Image Container
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    color: const Color.fromRGBO(53, 108, 254, 1),
                    child: Image.asset(
                      'images/password_recover.jpg',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  // Txt Field Container
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'SearchaHolic',
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
                // Creating a Text Row for the Title
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///getting password from database and check password match or not
  Future password_check(String password) async {
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
    if (data2['password'] != password) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  bool newpassword_match(String newpassword, String confirmpassword) {
    if (newpassword != confirmpassword) {
      return true;
    } else {
      return false;
    }
  }

  ///change password
  Future<bool> change(String password1) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];
    try {
      // Adding the product to the database
      await Firestore.instance
          .collection(email)
          .document("Store Details")
          .update({
        'password': password1,
      });
      return Future<bool>.value(true);
    } catch (e) {
      print("Not Connected to the Internet");
      return Future<bool>.value(false);
    }
  }
  /*Future<bool> foget_p() async {
    // Add Product to the Database
    if (await Flutter_api().forget_p(_email.text, _password.text)) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }*/
  //}
}
