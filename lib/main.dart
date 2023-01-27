// ignore_for_file: prefer_const_constructors, avoid_print

import 'imports.dart';
import 'package:firedart/firedart.dart';

const api_key = "AIzaSyCjZK5ojHcJQh8Sr0sdMG0Nlnga4D94FME";
const project_id = "searchaholic-86248";

// Showing Hello World in Flutter
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore.initialize(project_id); // Establishing connection with Firestore

  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(1000, 600));
    createFilesAndFolders();
  }
  runApp(MyApp());
}

// MY APP CLASSs

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

//Function to Create a Folder and File In the Document Directory
void createFilesAndFolders() async {
  // Creating A Folder in the Document Directory
  Directory directory = await getApplicationDocumentsDirectory();
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
