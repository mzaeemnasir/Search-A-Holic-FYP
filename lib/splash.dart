//Splash Screen
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// Creating a Splash Screen with Fixed Size of 800x1000

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
