// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, unrelated_type_equality_checks, unused_import, library_private_types_in_public_api, use_key_in_widget_constructors, sort_child_properties_last

import 'package:searchaholic/imports.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              child: Column(
                children: [
                  Container(
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
                      top: MediaQuery.of(context).size.height * 0.087,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.15),
                        ),
                      ),
                    ),
                  ),
                  // Store Name
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Store Name",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.15),
                        ),
                      ),
                    ),
                  ),
                  // Store Location
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Store Location",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.15),
                        ),
                      ),
                    ),
                  ),
                  // Store Manager's  Number
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.15),
                        ),
                      ),
                    ),
                  ),
                  // Password (with eye icon)
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.15),
                        ),
                      ),
                    ),
                  ),
                  // Register Button
                  Container(),
                  // Already have an account? Txt
                  Container(),
                  // Login Button
                  Container(),
                ],
              ),
            ),
          ),
          // Right Side
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Color.fromRGBO(53, 108, 254, 1),
            child: Expanded(
              child: Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(child: Container()),
                      WindowButtons()
                    ]),
                  ),
                  // Txt Field
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    margin: EdgeInsets.only(top: 20),
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
                    margin: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'images/registration.jpg',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  // Txt Field Container
                  Container(
                    margin: EdgeInsets.only(top: 20),
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
