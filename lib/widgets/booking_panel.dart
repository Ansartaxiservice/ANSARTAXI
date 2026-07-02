import 'package:flutter/material.dart';

import '../models/place_model.dart';
import 'location_search_field.dart';
import 'search_results.dart';

class BookingPanel extends StatelessWidget {
  final TextEditingController pickupController;
  final TextEditingController destinationController;

  final List<PlaceModel> searchResults;

  final ValueChanged<String> onDestinationChanged;
  final ValueChanged<PlaceModel> onPlaceSelected;

  final String distance;
  final String time;
  final String fare;

  final VoidCallback onBook;

  const BookingPanel({
    super.key,
    required this.pickupController,
    required this.destinationController,
    required this.searchResults,
    required this.onDestinationChanged,
    required this.onPlaceSelected,
    required this.distance,
    required this.time,
    required this.fare,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Where do you want to go?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LocationSearchField(
              controller: pickupController,
              hintText: "Pickup Location",
              icon: Icons.my_location,
            ),

            const SizedBox(height: 15),

            LocationSearchField(
              controller: destinationController,
              hintText: "Destination",
              icon: Icons.location_on,
              onChanged: onDestinationChanged,
            ),

            SearchResults(
              places: searchResults,
              onSelected: onPlaceSelected,
            ),

            const SizedBox(height: 20),
Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Distance"),
                        Text(
                          distance,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Estimated Time"),
                        Text(
                          time,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Estimated Fare"),
                        Text(
                          fare,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                onPressed: onBook,
                child: const Text(
                  "BOOK TAXI",
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
    );
  }
}
