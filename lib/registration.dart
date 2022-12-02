import 'package:flutter/services.dart';
import 'package:searchaholic/imports.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = TextEditingController();
  var storeName = TextEditingController();
  var storeLocationLat = TextEditingController();
  var storeLocationLong = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();

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
                      top: MediaQuery.of(context).size.height * 0.087,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextFormField(
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
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextFormField(
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
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          RegExp regExp = RegExp(
                            r"^[0-9]{10}$",
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
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: TextFormField(
                      obscureText: true,
                      maxLength: 18,
                      // validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
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
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey[450],
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
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
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
                        backgroundColor: Colors.blue,
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
          // Right Side
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: const Color.fromRGBO(53, 108, 254, 1),
            child: Expanded(
              child: Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(children: [
                      Expanded(child: Container()),
                      const WindowButtons()
                    ]),
                  ),
                  // Txt Field
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    margin: const EdgeInsets.only(top: 20),
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

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

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
