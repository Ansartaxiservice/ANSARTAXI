import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final VoidCallback onLocationPressed;

  const MapWidget({
    super.key,
    required this.mapController,
    required this.onLocationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(15.4909, 73.8278),
            initialZoom: 12,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: "com.example.ansartaxi",
            ),
          ],
        ),

        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            onPressed: onLocationPressed,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
