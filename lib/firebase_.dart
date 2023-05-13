// ignore_for_file: avoid_print, camel_case_types, non_constant_identifier_names
// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:alert/alert.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'imports.dart';
import 'package:firedart/firedart.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:collection/collection.dart';

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

  // check offline login
  Future<bool> check_offline(String email, String password) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String localEmail = jsonDecode(file.readAsStringSync())['email'];
    String localPassword = jsonDecode(file.readAsStringSync())['password'];

    if (localEmail == email && localPassword == password) {
      print("Login Successfull");
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  // checking login of members
  Future<bool> check_login(String email, String password) async {
    // if internet is not connected then login offline (with the credentials saved from the last login)
    if (await check_offline(email, password)) {
      return Future<bool>.value(true);
    }

    // Getting the User Collection
    final managers = Firestore.instance.collection(email);
    print(managers);

    final manager = managers.document("Store Details");
    print(manager);
    print("Got Managers");
    try {
      print("Trying to get Data");
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
        'phNo': phNo,
        'password': password,
        "storeLocation": GeoPoint(double.parse(lat), double.parse(long)),
        "storeId": await generateStoreId(email),
      });
      print("Data Added");
      return Future<bool>.value(true);
    }
  }

  Future<bool> addProduct(String productName, String productPrice,
      String productQty, String productType) async {
    String email = await getEmail();
    String storeID = await generateStoreId(email);
    String productID = await generateProductId(productName);
    List storeDetails = await getStoreDetails();

    try {
      Document x = await getAllProducts();
      if (x == null) {
        print("No Products");
        return Future<bool>.value(false);
      }
      Map<String, dynamic> data =
          x.map; //Maping the data to the data variable (Map<String, dynamic>)

      // Cecking if the product is already present add the quantity
      if (data.containsKey(productID)) {
        int prevQty = int.parse(data[productID]['Quantity']);
        int newQty = prevQty + int.parse(productQty);
        data[productID]['Quantity'] = newQty.toString();
      } else {
        print(data.length);
        // Adding the product to the product collection (prevData
        data.addAll({
          productID: {
            'Name': productName,
            'Quantity': productQty,
            'Price': productPrice,
            'Type': productType,
            'Expiry': "Not Set",
            'Category': "Not Set",
            "StoreId": storeID,
            "ProductId": productID,
            "StoreName": storeDetails[0],
            "StoreLocation": GeoPoint(
                double.parse(storeDetails[1]), double.parse(storeDetails[2])),
          },
        });
      }
      await Firestore.instance
          .collection("Products")
          .document(storeID)
          .set(data);
      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      print("Not Connected to the Internet");
      return Future<bool>.value(false);
    }
  }

  Future<bool> email_check(String email1) async {
    final managers = Firestore.instance.collection(email1);
    print(managers);

    final manager = managers.document("Store Details");
    print(manager);
    print("Got Managers");

    // Getting the Data from the Document
    try {
      final data = await manager.get();
      if (data['email'] == email1) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } catch (e) {
      print("Error Occured - Does not Find Data ");
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

  // Add Order
  Future<bool> addOrder(
      List<dynamic> selectedProc, var totalBill, var phoneNo) async {
    var email = await getEmail();
    var time = DateTime.now();
    var saleId = await generateStoreId(time.toString());

    Map saleProducts = Map();

    // Storing the products in the map in key value pair key == productName value == quantity

    for (var i = 0; i < selectedProc.length; i++) {
      // if product is already in saleProducts then add the quantity
      if (saleProducts.containsKey(selectedProc[i]["Name"])) {
        int prevQty = int.parse(saleProducts[selectedProc[i]["Name"]]);
        int newQty = prevQty + int.parse(selectedProc[i]["Quantity"]);
        saleProducts[selectedProc[i]["Name"]] = newQty.toString();
        continue;
      }
      saleProducts.addAll({
        selectedProc[i]["Name"]: selectedProc[i]["Quantity"],
      });
    }

    try {
      Firestore.instance.collection("Sales").document(saleId).set({
        "customerPhone": phoneNo.toString(),
        "saleAmount": totalBill,
        "saleDate": time,
        "saleProducts": saleProducts,
      });
      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      return Future<bool>.value(false);
    }
  }

  // Updating the Products Quantity
  Future<bool> updateProductsQuantity(List<Document> selectedProc) async {
    var email = await getEmail();
    print(email);
    try {
      for (var i = 0; i < selectedProc.length; i++) {
        Firestore.instance
            .collection(email)
            .document("Product")
            .collection("products")
            .document(selectedProc[i].id)
            .update({
          'productQty': selectedProc[i]["quantity"],
        });
      }
      return Future<bool>.value(true);
    } catch (e) {
      print("Not Connected to the Internet");
      return Future<bool>.value(false);
    }
  }

  getEmail() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    Directory folder = Directory('$path/SeachAHolic');

    // getting the email from the user.json file
    File file = File('$path/SeachAHolic/user.json');
    String email = jsonDecode(file.readAsStringSync())['email'];
    return email;
  }

  // Generate StoreID based on the email using MD5
  String generateStoreId(String email) {
    var content = new Utf8Encoder().convert(email);
    var digest = md5.convert(content);
    return digest.toString();
  }

  // Generate ProductID based on the productName using MD5
  String generateProductId(String productName) {
    var content = new Utf8Encoder().convert(productName);
    var digest = md5.convert(content);
    return digest.toString();
  }

  // Converting File Data To Correct Format csv to list of products with productId and Store ID
  Future<List<List<dynamic>>> readCsvFile(String filePath) async {
    final input = File(filePath).openRead();
    final fields = [
      'product_name',
      'product_quantity',
      'product_price',
      'product_type',
      'product_expiry',
      'product_category'
    ];
    const parser = CsvToListConverter(
        eol: '\n', fieldDelimiter: ',', shouldParseNumbers: true);

    final result =
        await input.transform(utf8.decoder).transform(parser).toList();

    result.removeAt(0);
    return result;
  }

  // listCompare function

  bool listEql(List a, List b) {
    print(a);
    print(b);
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  // get Store Name and Store Locaion by email
  Future<List<String>> getStoreDetails() async {
    String email = await getEmail();
    var data = await Firestore.instance
        .collection(email)
        .document("Store Details")
        .get();
    var lat = data['storeLocation'].latitude.toString();
    var lon = data['storeLocation'].longitude.toString();
    List<String> storeDetails = [
      data['storeName'],
      lat,
      lon,
    ];
    return storeDetails;
  }

  // check csv file herder and return the if the file is valid or not
  Future<bool> check_file_header(String filepath) async {
    final file = File(filepath).openRead();
    final fields = [
      'product_name',
      'product_quantity',
      'product_price',
      'product_type',
      'product_expiry',
      'product_category'
    ];
    final input = await file.transform(utf8.decoder).toList();
    return Future<bool>.value(true);
    // var newFields = input[0].split(',');
    // if (listEql(fields.toString() isnewFields.elementAt(0).toString())) {
    //   print("File is Valid");
    //   return Future<bool>.value(true);
    // } else {
    //   print("File is not Valid");
    //   return Future<bool>.value(false);
    // }
  }

  // Uploading the File to the Data Base Against the StoreId
  Future<bool> uploadFile(String filePath) async {
    try {
      Map<String, dynamic> data = {};
      String storeID = generateStoreId(await getEmail());
      List<List<dynamic>> products = await readCsvFile(filePath);
      List<String> storeDetails = await getStoreDetails();

      // Adding the products to the database using addProduct function
      for (var i = 0; i < products.length; i++) {
        String productId = generateProductId(products[i][0]);
        var x = {
          productId: {
            "Name": products[i][0],
            "Quantity": products[i][1],
            "Price": products[i][2],
            "Type": products[i][3],
            "Expire": products[i][4],
            "Category": products[i][5],
            "StoreId": storeID,
            "ProductId": productId,
            "StoreName": storeDetails[0],
            "StoreLocation": GeoPoint(
                double.parse(storeDetails[1]), double.parse(storeDetails[2])),
          }
        };
        data.addAll(x);
      }
      await adddProduct(data);
      print("Products Uploaded Successfully");
      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future<bool> adddProduct(Map<String, dynamic> Data) async {
    try {
      final storeId = generateStoreId(await getEmail());
      // Uploading the Product to the database
      Firestore.instance.collection("Products").document(storeId).set(Data);
      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future<Document> getAllProducts() async {
    final storeId = generateStoreId(await getEmail());

    try {
      Document data = await Firestore.instance
          .collection("Products")
          .document(storeId)
          .get();

      return Future<Document>.value(data);
    } catch (e) {
      print("No Products Found");
      return Future<Document>.value(null);
    }
  }
}

// Data Model
/*
var DATA = {
          "Name": data["Name"],
          "Quantity": data["Quantity"], // double
          "Price": data["Price"], // double
          "Type": data["Type"], // Public, Private
          "ExpireDate": data["ExpireDate"], // Date
          "Category": data["Category"],
          "StoreId": store.id,
          "ProductId": product.id,
          "StoreName": data["StoreName"],
          "StoreLocation": data["StoreLocation"],
        };
        
        */

// // Add Product to database
// Future<bool> adddProduct(
//   String Name,
//   String Quantity,
//   String Price,
//   String Type,
//   String Expire,
//   String Category,
//   String StoreId,
//   String ProductId,
//   String StoreName,
//   List StoreLocation,
// ) async {
//   try {
//     // Uploading the Product to the database
//     Firestore.instance
//         .collection("products")
//         .document(StoreId)
//         .collection("product")
//         .document(ProductId)
//         .set({
//       "Name": Name,
//       "Quantity": Quantity, // double
//       "Price": Price, // double
//       "Type": Type, // Public, Private
//       "ExpireDate": Expire, // Date
//       "Category": Category,
//       "StoreId": StoreId,
//       "ProductId": ProductId,
//       "StoreName": StoreName,
//       "StoreLocation": GeoPoint(
//           double.parse(StoreLocation[1]), double.parse(StoreLocation[2])),
//     });
//     print("Product ${Name} added");
//     return Future<bool>.value(true);
//   } catch (e) {
//     print(e);
//     return Future<bool>.value(false);
//   }
// }
