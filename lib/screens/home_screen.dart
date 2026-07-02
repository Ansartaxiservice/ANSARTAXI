
import '../widgets/map_widget.dart';
import '../controllers/map_controller.dart';
import '../services/distance_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../widgets/taxi_selection_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/place_model.dart';
import '../services/geocoding_service.dart';
import '../services/location_service.dart';
import '../services/search_service.dart';
import '../widgets/booking_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController mapController = MapController();
  final MapStateController mapState = MapStateController();
  final TextEditingController pickupController =
      TextEditingController();

  final TextEditingController destinationController =
      TextEditingController();

  Position? currentPosition;

  LatLng? destinationPoint;

  List<PlaceModel> searchResults = [];

  String distance = "0.0 km";
  String time = "0 min";
  String fare = "₹100";

  Future<void> getCurrentLocation() async {
    final position =
        await LocationService.getCurrentLocation();

    if (position == null) return;

    setState(() {
      currentPosition = position;
    });

    final address =
        await GeocodingService.getAddress(
      position.latitude,
      position.longitude,
    );

    if (address != null) {
      pickupController.text = address;
    }

    mapController.move(
      LatLng(
        position.latitude,
        position.longitude,
      ),
      16,
    );
  }

  Future<void> searchDestination(
      String value) async {
    final results =
        await SearchService.search(value);

    setState(() {
      searchResults = results;
    });
  }

  void selectPlace(PlaceModel place) {
  destinationController.text = place.name;

  final pickup = currentPosition;

  if (pickup != null) {
    final pickupLatLng = LatLng(
      pickup.latitude,
      pickup.longitude,
    );

    destinationPoint = LatLng(
  place.latitude,
  place.longitude,
);

final destinationLatLng = destinationPoint!;

    final distanceKm =
        DistanceService.calculateDistance(
      pickupLatLng,
      destinationLatLng,
    );

    setState(() {
      searchResults.clear();

      distance =
          "${distanceKm.toStringAsFixed(1)} km";

      time =
          "${DistanceService.estimateTime(distanceKm)} min";

      fare =
          "₹${DistanceService.calculateFare(distanceKm).toStringAsFixed(0)}";
    });
  } else {
    setState(() {
      searchResults.clear();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            MapWidget(
  mapController: mapController,
  initialCenter: const LatLng(
    15.4909,
    73.8278,
  ),
  pickup: currentPosition == null
      ? null
      : LatLng(
          currentPosition!.latitude,
          currentPosition!.longitude,
        ),
destination: destinationPoint,
),

            Positioned(
              top: 20,
              left: 20,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
              ),
            ),

            Positioned(
              top: 20,
              right: 20,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                ),
              ),
            ),
Positioned(
              right: 20,
              bottom: 420,
              child: FloatingActionButton(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                onPressed: getCurrentLocation,
                child: const Icon(Icons.my_location),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BookingPanel(
                pickupController: pickupController,
                destinationController: destinationController,
                searchResults: searchResults,
                onDestinationChanged: searchDestination,
                onPlaceSelected: selectPlace,
                distance: distance,
                time: time,
                fare: fare,
                onBook: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const TaxiSelectionSheet(),
  );
},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
