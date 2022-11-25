// Login Screen

// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, unrelated_type_equality_checks

// Importing the required packages
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:searchaholic/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:searchaholic/firebase_.dart';
import 'package:searchaholic/registration.dart';
import 'package:searchaholic/system.dart';
// Login Screen

// ignore: use_key_in_widget_constructors

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => LoginScreen();
}

class LoginScreen extends State<Login> {
  // VARIABLES
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Creating 2 Containers Left and Right
      body: Row(
        children: [
          // Left Container
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Expanded(
              child: Column(
                children: [
                  // Variable to store the Login Email and Password

                  // 1. Login Text
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 2. Email Text Field
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ),
                  ),
                  // 3. Password Text Field
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ),
                  ),
                  // 4. Forget Password Text Label
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    // Setting the Alignment to Right
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.centerRight,
                    // Clickable Text
                    child: RichText(
                        text: TextSpan(
                      text: "Forget?",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Forget Password- Page");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ForgetPassword()));
                        },
                    )),
                  ),
                  // 5. Login Button
                  Container(
                      margin: EdgeInsets.only(top: 20, left: 150, right: 150),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          //  On Press Show Loading Animation in the Login Button
                          setState(() {
                            // Validate the Email and Password
                            var object = LoginCheck(email, password);
                            if (object.Validator() == "valid") {
                              // If Valid then Navigate to the Home Screen
                              print("Valid");
                              object.checkLogin();
                            } else {
                              // If Invalid then Show the Error Message
                              if (object.Validator() == "emptyEmail" ||
                                  object.Validator() == "emptyPassword") {
                                print("Please Enter the Email and Password");
                              }
                              if (object.Validator() == "invalidEmail") {
                                print("Please Enter a Valid Email");
                              }
                            }
                          }); // End of Set State , // End of Set State
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      )),

                  // 6. Create Account Text Label
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have Account?",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: " Create one!",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()),
                                        ),
                                      })
                          ]),
                    ),
                  ),
                ], // End of Column Children
              ),
            ),
          ),

          // Right Container
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(53, 108, 254, 1),

              // Setting up a Logo in the Center
              child: Expanded(
                  child: Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(child: Container()),
                      WindowButtons()
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      "Welcome To\nSearchaholic!",
                      style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Image.asset(
                        'images/logo.png',
                        height: MediaQuery.of(context).size.height * 0.42,
                        width: MediaQuery.of(context).size.width * 0.42,
                      ),
                    ),
                  ),
                ],
              )))
        ], // End of Row Children (Right Container)
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            mouseOver: Colors.blue,
            iconNormal: Colors.white,
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            mouseOver: Colors.blue,
            iconNormal: Colors.white,
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            iconNormal: Colors.white,
            mouseOver: Colors.red,
          ),
        ),
      ],
    );
  }
}

// Login Check Class

class LoginCheck {
  // Variables
  var email = TextEditingController();
  var password = TextEditingController();
  var context = BuildContext;
  // Constructor
  LoginCheck(this.email, this.password);

  // Validating Email and Password

  String Validator() {
    // If Email is Empty
    if (email.text == "") {
      return "emptyEmail"; // Error Message
    }
    // If Password is Empty
    else if (password.text == "") {
      return "emptyPassword"; // Error Message
    }
    // If Email is not Valid
    else if (!EmailValidator.validate(email.text)) {
      return "invalidEmail"; // Error Message
    }
    // If Email and Password is Valid
    else {
      return "valid"; // Error Message
    }
  }

  // Function to check the Login
  void checkLogin() {
    // Checking the Login Credentials From Firebase
    Flutter_api().check_login(email.text, password.text).then((value) => {
          if (value == true)
            {
              print("Setting Shared Preferences"),
              System().setLogin(email.text, password.text).then((value) => {
                    print("Shared Preferences Set")
                    //  Navigator.pushReplacement(
                  }),
            }
          else
            {
              print("Invalid Login"),
            }
        });
  }
}
