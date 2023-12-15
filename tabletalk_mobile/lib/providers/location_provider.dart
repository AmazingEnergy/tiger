import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  final Location _location = Location();
  LocationData? _currentLocation;

  LocationData? get currentLocation => _currentLocation;

  Future<void> getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      notifyListeners();
    } catch (e) {
      debugPrint('[LocationProvider] Error getting location: $e');
    }
  }
}
