//Splash Screen
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Creating a Splash Screen with Fixed Size of 800x1000

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting up the Window Size

      body: Center(
        child: Container(
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
