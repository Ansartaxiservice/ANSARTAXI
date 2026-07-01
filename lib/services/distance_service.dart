import 'package:latlong2/latlong.dart';

class DistanceService {
  static final Distance _distance = const Distance();

  static double calculateDistance(
    LatLng pickup,
    LatLng destination,
  ) {
    return _distance.as(
          LengthUnit.Kilometer,
          pickup,
          destination,
        );
  }

  static int estimateTime(double distanceKm) {
    return (distanceKm / 35 * 60).round();
  }

  static double calculateFare(double distanceKm) {
    const double baseFare = 100;
    const double perKm = 18;

    return baseFare + (distanceKm * perKm);
  }
}
