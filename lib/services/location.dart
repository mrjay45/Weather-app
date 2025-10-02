import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;
  Future getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      FlutterError('Location service ps disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // request the permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        FlutterError('Location permission is denied');
      }
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }

    if (permission == LocationPermission.deniedForever) {
      FlutterError(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }
}
