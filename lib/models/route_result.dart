import 'package:latlong2/latlong.dart';

class RouteResult {
  final List<LatLng> points;
  final double distanceKm;
  final int durationMin;

  RouteResult({
    required this.points,
    required this.distanceKm,
    required this.durationMin,
  });
}

