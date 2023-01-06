import 'dart:convert';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/imports.dart';
import 'package:form_field_validator/form_field_validator.dart';

// ignore: use_key_in_widget_constructors

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => LoginScreen();
}

class LoginScreen extends State<Login> {
  // VARIABLES

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  var email = TextEditingController();
  var password = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    checkLoginFile().then((value) {
      if (value == true) {
        getDetails().then((value) {
          email.text = value[0];
          password.text = value[1];
        });
      }
    });
  }

  void onClickFun(RoundedLoadingButtonController btnController) async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  void onClickFun2(RoundedLoadingButtonController btnController) async {
    Timer(Duration(seconds: 2), () {
      _btnController.error();
      Future.delayed(Duration(seconds: 1));
      _btnController.reset();
    });
  }

  void myalert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Login Faild',
      text: 'Wrong Email or Password',
    );
  }

  void myalert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Login Successful',
      text: '',
    );
  }

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
            color: Color.fromRGBO(250, 250, 250, 255),
            child: Expanded(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    // Variable to store the Login Email and Password

                    // 1. Login Text
                    Container(
                      margin: EdgeInsets.only(top: 160),
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // 2. Email Text Field
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Email Required'),
                            EmailValidator(
                                errorText: 'Please enter a valid Email')
                          ],
                        ),
                      ),
                    ),
                    // 3. Password Text Field

                    Container(
                      margin: EdgeInsets.only(top: 25),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Password Required'),
                          ],
                        ),
                        obscureText: _isObscure,
                        controller: password,
                        cursorColor: Color.fromRGBO(53, 108, 254, 1),
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
                            color: Color.fromRGBO(53, 108, 254, 1)),
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
                        margin: EdgeInsets.only(top: 30, left: 150, right: 150),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        child: RoundedLoadingButton(
                          onPressed: () {
                            formkey.currentState?.validate();
                            //  On Press Show Loading Animation in the Login Button
                            setState(() async {
                              // Validate the Email and Password
                              var object_flutterApi = Flutter_api();
                              var object = LoginCheck(email, password);

                              if (object.Validator() == "emptyEmail" ||
                                  object.Validator() == "emptyPassword") {
                                // If Invalid then Show the Error Message
                                print("Please Enter the Email and Password");
                                onClickFun2(_btnController);
                              } else if (await object_flutterApi.check_login(
                                      email.text, password.text) ==
                                  true) {
                                // If Valid then Navigate to the Home Screen
                                print("Valid");
                                object.checkLogin(context);
                                onClickFun(_btnController);
                                myalert1();
                                await updateLoginFile(
                                    email.text, password.text);
                              } else if (await object_flutterApi.check_login(
                                      email.text, password.text) ==
                                  false) {
                                myalert();
                                onClickFun2(_btnController);
                              }
                            });

                            // End of Set State , // End of Set State
                          },

                          controller: _btnController,
                          color: Color.fromRGBO(53, 108, 254, 1),
                          // style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.blue,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30))),
                          child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )),

                    // 6. Create Account Text Label
                    Container(
                      margin: EdgeInsets.only(top: 15),
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
                                      color: Color.fromRGBO(53, 108, 254, 1)),
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
          ),

          // Right Container
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              //color: Colors.white,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(53, 108, 254, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(740),
                    bottomLeft: Radius.circular(640),
                  )),

              // Setting up a Logo in the Center
              child: Expanded(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 120, left: 90),
                    child: Text(
                      "Welcome to",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Text(
                      "Searchaholic!",
                      style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
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
    //else if (!EmailValidator.validate(email.text)) {
    //return "invalidEmail"; // Error Message
    //}
    // If Email and Password is Valid
    else {
      return "valid"; // Error Message
    }
  }

  //Checking the Login File in Shared Preferences
  // Function to check the Login
  void checkLogin(BuildContext context) {
    // Checking the Login Credentials From Firebase
    Flutter_api().check_login(email.text, password.text).then((value) => {
          if (value == true)
            {
              print(value),
              print("Setting Shared Preferences"),
              System().setLogin(email.text, password.text).then(
                    (value) => {
                      print("Login File Set"),
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      ),
                    },
                  ),
            }
          else
            {
              print("invalid Login"),
            }
        });
  }
}

// Updating the Login File
Future<bool> updateLoginFile(String email, String password) async {
  // Getting the Login File
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  Directory folder = Directory('$path/SeachAHolic');
  File file = File('$path/SeachAHolic/user.json');

  // Updating the Login File
  if (await folder.exists() && file.existsSync()) {
    print("Login File Exists");
    file.writeAsStringSync(
        '{"email": "$email", "password": "$password"}'); // Writing the File
    print("user.json Updated");
    return Future<bool>.value(true);
  } else {
    return Future<bool>.value(false);
  }
}

Future<bool> checkLoginFile() async {
  // Getting the Login File
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  Directory folder = Directory('$path/SeachAHolic');
  File file = File('$path/SeachAHolic/user.json');

  // Checking the Login File
  if (await folder.exists() && file.existsSync()) {
    print("Login File Exists");
    return Future<bool>.value(true);
  } else {
    return Future<bool>.value(false);
  }
}

//getting Email and Password from the file
Future<List> getDetails() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  File file = File('$path/SeachAHolic/user.json');

  var data = jsonDecode(file.readAsStringSync());
  return Future<List>.value([data['email'], data['password']]);
}
