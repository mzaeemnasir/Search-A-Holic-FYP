// This contain functions for api calls

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class ApiCall {
  Future<Position> getCurrentLocation() async {
    var status = await Permission.location.status;

    PermissionStatus permission = await Permission.location.request();
    if (permission != PermissionStatus.granted) {
      print("Permission not granted");
      throw Exception('Location permission not granted');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }
}
