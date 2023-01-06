// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:searchaholic/firebase_.dart';
import 'package:searchaholic/imports.dart';
import 'package:quickalert/quickalert.dart';
import 'package:email_otp/email_otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool otpst = false;
  var email = TextEditingController();
  var storeName = TextEditingController();
  var storeLocationLat = TextEditingController();
  var storeLocationLong = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var otp = TextEditingController();

  bool _isObscure = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'Invalid credentials!!',
    );
  }

  void showAlert1() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Yahoooo...',
        text: 'Registration successful!!',
        confirmBtnText: 'Ok',
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
        });
  }

  void showOtpSentSuccess() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'OTP Successfully sent!',
    );
  }

  void showOtpSuccess() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Yahoooo...',
      text: 'OTP verified',
    );
  }

  void showOtpFailure() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Opps!!',
      text: 'OTP was not verified',
    );
  }

  EmailOTP myauth = EmailOTP();
  void sendOTP() async {
    myauth.setConfig(
        appEmail: "Searchaholic@gmail.com",
        appName: "Searchaholic",
        userEmail: email.text,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    var res = await myauth.sendOTP();
    if (res) {
      print("otp sent");
    } else {
      print("otp didnt sent");
    }
  }

  void verifyOtp() {
    var res = myauth.verifyOTP(otp: otp.text);
    if (res) {
      setState(() {
        otpst = true;
        print("otp true");
      });
      print("verfied");
    } else {
      print("otp didnt verified");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side
          Container(
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
                          "Registration",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Text Field Email
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.027,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              caseSensitive: false,
                              multiLine: false,
                            );

                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid email address';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
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
                    // Store Name
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name required';
                          } else {
                            RegExp regExp = RegExp(
                              r"^[A-Za-z\s]*$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!regExp.hasMatch(value)) {
                              // Make input field red
                              return 'Please enter a valid name';
                            }
                          }
                          return null;
                        },
                        controller: storeName,
                        decoration: InputDecoration(
                          hintText: "Store Name",
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
                    // Store Location
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        controller: storeLocationLong,
                        decoration: InputDecoration(
                          hintText: "Store Location",
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
                    // Store Manager's  Number
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        controller: phoneNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                        //allow only numbers
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: "Phone Number",
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
                    // Password (with eye icon)
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: TextFormField(
                        obscureText: _isObscure,
                        maxLength: 18,
                        // validation
                        controller: password,
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
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.0005,
                      ),
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: otp,
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          suffixIcon: TextButton(
                              child: const Text("Send OTP"),
                              onPressed: () => {
                                    if (formkey.currentState!.validate())
                                      {
                                        sendOTP(),
                                        showOtpSentSuccess(),
                                      }
                                  }),
                          suffix: TextButton(
                              child: const Text("Verify"),
                              onPressed: () => {
                                    verifyOtp(),
                                    if (otpst)
                                      {
                                        showOtpSuccess(),
                                      }
                                    else if (otpst == false)
                                      {
                                        showOtpFailure(),
                                      }
                                    else
                                      {
                                        print("failure"),
                                      }
                                  }),
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 10,
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
                        top: MediaQuery.of(context).size.height * 0.025,
                      ),
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Register Button Pressed");

                          // Validate returns true if the form is valid, or false otherwise.
                          // if (_formKey.currentState!.validate()) {
                          //   // If the form is valid, display a snackbar. In the real world,
                          //   // you'd often call a server or save the information in a database.+
                          //   print("Form is valid");
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }

                          if (formkey.currentState!.validate()) {
                            if (otpst) {
                              Flutter_api().register(
                                  email.text,
                                  storeName.text,
                                  storeLocationLong.text,
                                  phoneNumber.text,
                                  password.text);
                              setState(() {
                                otpst = false;
                              });

                              showAlert1();
                            } else {
                              showOtpFailure();
                            }
                          } else {
                            print("error");
                            showAlert();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(53, 108, 254, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Register",
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
                              builder: (context) => const Login(),
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
                          "Already have account? Login",
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
            color: const Color.fromRGBO(53, 108, 254, 1),
            child: Expanded(
              child: Column(
                children: [
                  // Txt Field
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      "Sign up",
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
                      'images/registration.jpg',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  // Txt Field Container
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Welcome to SearchAHolic',
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
}
