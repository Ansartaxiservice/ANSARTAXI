import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeMap extends StatelessWidget {
  final MapController mapController;
  final LatLng center;
  final LatLng? pickup;
  final LatLng? destination;
  final List<LatLng> routePoints;

  const HomeMap({
    super.key,
    required this.mapController,
    required this.center,
    this.pickup,
    this.destination,
    this.routePoints = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.ansartaxi",
        ),

        if (routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                strokeWidth: 5,
                color: Colors.blue,
              ),
            ],
          ),

        MarkerLayer(
          markers: [
            if (pickup != null)
              Marker(
                point: pickup!,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.green,
                  size: 42,
                ),
              ),

            if (destination != null)
              Marker(
                point: destination!,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 42,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

