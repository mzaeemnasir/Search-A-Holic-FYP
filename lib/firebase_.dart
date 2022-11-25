// ignore_for_file: avoid_print, camel_case_types, non_constant_identifier_names
// ignore_for_file: constant_identifier_names
import 'imports.dart';
import 'package:firedart/firedart.dart';

const api_key = "AIzaSyCjZK5ojHcJQh8Sr0sdMG0Nlnga4D94FME";
const project_id = "searchaholic-86248";

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
    final managers = Firestore.instance.collection('managers');

    final manager = managers.document(email);
    print("Got Managers");
    // Getting the Data from the Document
    try {
      final data = await manager.get();
      if (data['password'] == password) {
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

  // Adding a New Manager
  // Future<bool> add_manager(String email, String storeName, String longitude,
  //     String latitude, String phoneNumber, String password) async {}
}
