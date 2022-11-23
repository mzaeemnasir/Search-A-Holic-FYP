// Login Screen

// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, prefer_const_literals_to_create_immutables

// Importing the required packages
import 'package:flutter/material.dart';
import 'package:searchaholic/imports.dart';

// Login Screen

// ignore: use_key_in_widget_constructors

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => LoginScreen();
}

class LoginScreen extends State<Login> {
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
          // Creating 6 Rows in the Left Container
          // 1.  Login Text
          // 2. Email Text Field
          // 3. Password Text Field
          // 4. Forget Password Text Label
          // 5. Login Button
          // 6. Create Account Text Label

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Aligning the Text to Center
            children: [
              // Expanded(),

              // Login Text
              Column(
                children: [],
              ),
              // Email Text Field
              Column(),
              // Password Text Field
              Row(),
              // Forget Password Text Label
              Row(),
              // Login Button
              Row(),
              // Create Account Text Label
              Row(),
            ],
          ),
        ),
        // Right Container
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(53, 108, 254, 100),

          // Setting up a Logo in the Center
          child: Center(
            child: Image.asset(
              'images/logo.png',
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.55,
            ),
          ),
        )
      ],
    ));
  }
}

class MyClipper {
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }
}
