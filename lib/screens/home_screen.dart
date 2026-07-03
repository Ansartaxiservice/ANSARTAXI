import '../services/route_service.dart';
import '../widgets/home_map.dart';
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
List<LatLng> routePoints = [];

  List<PlaceModel> searchResults = [];

  String distance = "0.0 km";
  String time = "0 min";
  String fare = "₹100";
String selectedTaxi = "Mini";
double fareMultiplier = 1.0;
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

  Future<void> selectPlace(PlaceModel place) async {
  destinationController.text = place.name;

  if (currentPosition == null) {
    setState(() {
      searchResults.clear();
    });
    return;
  }

  final pickupLatLng = LatLng(
    currentPosition!.latitude,
    currentPosition!.longitude,
  );

  final destinationLatLng = LatLng(
    place.latitude,
    place.longitude,
  );

  
final routeResult = await RouteService.getRoute(
  pickupLatLng,
  destinationLatLng,
);
  setState(() {
  destinationPoint = destinationLatLng;
  routePoints = routeResult.points;

  searchResults.clear();

  distance =
      "${routeResult.distanceKm.toStringAsFixed(1)} km";

  time = "${routeResult.durationMin} min";

  fare =
      "₹${DistanceService.calculateFare(routeResult.distanceKm).toStringAsFixed(0)}";
});

mapController.move(destinationLatLng, 14);
}     

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            HomeMap(
  mapController: mapController,
  center: currentPosition == null
      ? const LatLng(15.4909, 73.8278)
      : LatLng(
          currentPosition!.latitude,
          currentPosition!.longitude,
        ),
  pickup: currentPosition == null
      ? null
      : LatLng(
          currentPosition!.latitude,
          currentPosition!.longitude,
        ),
  destination: destinationPoint,
  routePoints: routePoints,
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
                onBook: () async {
  final selectedTaxi = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const TaxiSelectionSheet(),
  );

  if (selectedTaxi == null) return;
setState(() {
  this.selectedTaxi = selectedTaxi["name"];

  switch (this.selectedTaxi) {
    case "Mini":
      fareMultiplier = 1.0;
      break;

    case "Sedan":
      fareMultiplier = 1.3;
      break;

    case "SUV":
      fareMultiplier = 1.7;
      break;

    case "XL":
      fareMultiplier = 2.2;
      break;
  }

  final currentFare = double.parse(
    fare.replaceAll("₹", ""),
  );

  fare =
      "₹${(currentFare * fareMultiplier).toStringAsFixed(0)}";
});

},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
