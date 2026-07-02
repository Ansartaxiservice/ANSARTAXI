import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng initialCenter;
  final LatLng? pickup;
  final LatLng? destination;
  final List<LatLng> routePoints;

  const MapWidget({
    super.key,
    required this.mapController,
    required this.initialCenter,
    this.pickup,
    this.destination,
    this.routePoints = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: 12,
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
                width: 45,
                height: 45,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),

            if (destination != null)
              Marker(
                point: destination!,
                width: 45,
                height: 45,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
          ],
        ),
      ],
    );
  }
}	

