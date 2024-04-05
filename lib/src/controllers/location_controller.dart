import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationController {
  Location location = Location();

  Future<Map<String, double>?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      return {
        'latitude': userLocation.latitude!,
        'longitude': userLocation.longitude!,
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      return null;
    }
  }
}