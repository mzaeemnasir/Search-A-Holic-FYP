// ignore_for_file: avoid_print, camel_case_types, non_constant_identifier_names
// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:alert/alert.dart';
import 'imports.dart';
import 'package:firedart/firedart.dart';

const api_key = "AIzaSyCjZK5ojHcJQh8Sr0sdMG0Nlnga4D94FME";
const project_id = "searchaholic-86248";
// const api_key = "AIzaSyBg4u6aeIDzvj4ZfPSnTGAzNBDR5sbui_U";
// const project_id = "searchaholic-3f04a";

class Flutter_api {
  // Main Function
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Firestore.initialize(project_id); // Establishing connection with Firestore
    print("Firestore Initialized");
  }

  // checking login of members
  Future<bool> check_login(String email, String password) async {
    // Getting the User Collection
    final managers = Firestore.instance.collection(email);
    print(managers);

    final manager = managers.document("Store Details");
    print(manager);
    print("Got Managers");

    // Getting the Data from the Document
    try {
      final data = await manager.get();
      if (data['password'] == password && data['email'] == email) {
        print("Login Successful");
        return Future<bool>.value(true);
      } else {
        print("Login Failed");
        return Future<bool>.value(false);
      }
    } catch (e) {
      print("Error Occured - Does not Find Data ");
      return Future<bool>.value(false);
    }
  }

  // Registration
  Future<bool> register(String email, String storeName, String Location,
      String phNo, String password) async {
    // Splitting the Location
    List<String> location = Location.split(",");
    String lat = location[0];
    String long = location[1];

    // Checking if the email is already registered
    final managers = Firestore.instance.collection(email);

    // Checking for the document with the email
    if (await managers.document(email).exists) {
      print(managers.document(email));
      print("Email Already Registered");
      return Future<bool>.value(false);
    } else {
      // Creating a new document with the email
      final manager = managers.document("Store Details");
      print("Created New Document");
      // Adding the data to the document
      await manager.set({
        'email': email,
        'storeName': storeName,
        'lat': lat,
        'long': long,
        'phNo': phNo,
        'password': password,
      });
      print("Data Added");
      return Future<bool>.value(true);
    }
  }

  Future<bool> addProduct(String productName, String productPrice,
      String productQty, String productType) async {
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
          .document("Product")
          .collection("products")
          .add({
        'productName': productName,
        'productPrice': productPrice,
        'productQty': productQty,
        'productType': productType,
      });
      return Future<bool>.value(true);
    } catch (e) {
      print("Not Connected to the Internet");
      return Future<bool>.value(false);
    }
  }

  ///Email check
  Future<bool> email_check(String email1) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];
    if (email == email1) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  ///change password
  Future<bool> forget_p(String email1, String password) async {
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
        'password': password,
      });
      return Future<bool>.value(true);
    } catch (e) {
      print("Not Connected to the Internet");
      return Future<bool>.value(false);
    }
  }
}
