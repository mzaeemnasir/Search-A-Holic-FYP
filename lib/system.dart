// ignore_for_file: avoid_print

import 'dart:convert';

import 'imports.dart';

class System {
  // Creating Files
  void createFilesAndFolders() async {
    // Creating A Folder in the Document Directory
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // IF There is No Folder in the Document Directory
    if (!folder.existsSync()) {
      folder.create();
    }

    // Otherwise Check the File is Already Exists or Not
    File file = File('$path/SeachAHolic/products.csv');
    if (!file.existsSync()) {
      file.create();
      print("products.csv File Created");
    }

    // Checking Other Files
    File file2 = File('$path/SeachAHolic/user.json');
    if (!file2.existsSync()) {
      file2.create();
      print("user.json File Created");
    }

    // Logs File
    File file3 = File('$path/SeachAHolic/logs.txt');
    if (!file3.existsSync()) {
      file3.create();
      print("logs.txt File Created");
    }
  }

  // Function to Write Log File
  void writeLogFile(String log) async {
    // Getting the File
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File file = File('$path/SeachAHolic/logs.txt');

    // Writing the File
    file.writeAsString(log, mode: FileMode.append);
  }

  // Function to Read Login File
  Future<String> getLogin() async {
    // Getting the File
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File file = File('$path/SeachAHolic/user.json');

    // Reading the Email  and Password from JSON File
    String data = await file.readAsString();
    return data;
    // Converting the Data into JSON
    // final json = jsonDecode(data);
    // final email = json['email'];
    // final password = json['password'];
    // return email, password;
  }

  // Function to Write Login File to Json
  Future<bool> setLogin(String email, String password) async {
    // Getting the File
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      File file = File('$path/SeachAHolic/user.json');

      // Writing the File
      file.writeAsString(jsonEncode({'email': email, 'password': password}));
      return true;
    } catch (e) {
      return false;
    }
  }
}
