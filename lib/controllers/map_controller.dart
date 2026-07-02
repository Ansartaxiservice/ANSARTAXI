import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapStateController extends ChangeNotifier {
  LatLng? pickup;
  LatLng? destination;

  List<LatLng> routePoints = [];

  String distance = "0.0 km";
  String time = "0 min";
  String fare = "₹100";

  void setPickup(LatLng point) {
    pickup = point;
    notifyListeners();
  }

  void setDestination(LatLng point) {
    destination = point;
    notifyListeners();
  }

  void setRoute(List<LatLng> points) {
    routePoints = points;
    notifyListeners();
  }

  void updateRideDetails({
    required String distanceValue,
    required String timeValue,
    required String fareValue,
  }) {
    distance = distanceValue;
    time = timeValue;
    fare = fareValue;
    notifyListeners();
  }

  void clearRoute() {
    destination = null;
    routePoints.clear();
    distance = "0.0 km";
    time = "0 min";
    fare = "₹100";
    notifyListeners();
  }
}
