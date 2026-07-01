import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();

  final TextEditingController pickupController =
      TextEditingController();

  final TextEditingController destinationController =
      TextEditingController();

  List<dynamic> pickupSuggestions = [];
  List<dynamic> destinationSuggestions = [];

  Future<void> searchPlace(
      String query,
      bool isPickup,
      ) async {
    if (query.isEmpty) {
      setState(() {
        if (isPickup) {
          pickupSuggestions = [];
        } else {
          destinationSuggestions = [];
        }
      });
      return;
    }

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=jsonv2&limit=5",
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "AnsarTaxi",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        if (isPickup) {
          pickupSuggestions = data;
        } else {
          destinationSuggestions = data;
        }
      });
    }
  }

  void moveToPlace(dynamic place) {
    final lat = double.parse(place["lat"]);
    final lon = double.parse(place["lon"]);

    _mapController.move(
      LatLng(lat, lon),
      15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "AnsarTaxi",
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          SizedBox(
            height: 300,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  15.4909,
                  73.8278,
                ),
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName:
                  "com.example.ansartaxi",
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  TextField(
                    controller: pickupController,
                    onChanged: (value) {
                      searchPlace(value, true);
                    },
                    decoration: InputDecoration(
                      hintText: "Pickup Location",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon:
                      const Icon(Icons.my_location),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                  ),const SizedBox(height: 10),

                  if (pickupSuggestions.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: pickupSuggestions.length,
                        itemBuilder: (context, index) {
                          final place = pickupSuggestions[index];

                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(place["display_name"]),
                              onTap: () {
                                pickupController.text =
                                    place["display_name"];

                                pickupSuggestions = [];

                                moveToPlace(place);

                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: destinationController,
                    onChanged: (value) {
                      searchPlace(value, false);
                    },
                    decoration: InputDecoration(
                      hintText: "Destination",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon:
                          const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (destinationSuggestions.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            destinationSuggestions.length,
                        itemBuilder: (context, index) {
                          final place =
                              destinationSuggestions[index];

                          return Card(
                            child: ListTile(
                              leading: const Icon(
                                  Icons.location_on),
                              title: Text(
                                  place["display_name"]),
                              onTap: () {
                                destinationController.text =
                                    place["display_name"];

                                destinationSuggestions = [];

                                moveToPlace(place);

                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                    ),
const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Booking feature coming soon...",
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Book Taxi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
