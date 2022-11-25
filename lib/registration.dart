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
            color: Colors.red,
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
