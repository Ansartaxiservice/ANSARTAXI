import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../models/route_result.dart';

class RouteService {
  static Future<RouteResult> getRoute(
    LatLng start,
    LatLng end,
  ) async {
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "${start.longitude},${start.latitude};"
      "${end.longitude},${end.latitude}"
      "?overview=full&geometries=geojson",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      return RouteResult(
        points: [],
        distanceKm: 0,
        durationMin: 0,
      );
    }

    final data = jsonDecode(response.body);

    final route = data["routes"][0];

    final coordinates =
        route["geometry"]["coordinates"] as List;

    final points = coordinates.map((point) {
      return LatLng(
        point[1].toDouble(),
        point[0].toDouble(),
      );
    }).toList();

    final distanceKm =
        (route["distance"] as num).toDouble() / 1000;

    final durationMin =
        ((route["duration"] as num).toDouble() / 60)
            .round();

    return RouteResult(
      points: points,
      distanceKm: distanceKm,
      durationMin: durationMin,
    );
  }
}	

