class RideModel {
  final String pickup;
  final String destination;
  final String vehicle;
  final double distanceKm;
  final int durationMin;
  final double fare;

  const RideModel({
    required this.pickup,
    required this.destination,
    required this.vehicle,
    required this.distanceKm,
    required this.durationMin,
    required this.fare,
  });
}
