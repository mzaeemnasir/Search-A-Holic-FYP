// This contain functions for api calls

import 'package:geolocator/geolocator.dart';

class ApiCall {
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }
}
