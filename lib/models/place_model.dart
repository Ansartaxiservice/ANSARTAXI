class PlaceModel {
  final String name;
  final double latitude;
  final double longitude;

  const PlaceModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json["display_name"] ?? "",
      latitude: double.parse(json["lat"]),
      longitude: double.parse(json["lon"]),
    );
  }
}
