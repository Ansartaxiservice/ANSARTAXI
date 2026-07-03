import 'package:flutter/material.dart';

class RideDetailsCard extends StatelessWidget {
  final String pickup;
  final String destination;
  final String vehicle;
  final String distance;
  final String time;
  final String fare;

  const RideDetailsCard({
    super.key,
    required this.pickup,
    required this.destination,
    required this.vehicle,
    required this.distance,
    required this.time,
    required this.fare,
  });

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            detailRow("Pickup", pickup),
            detailRow("Destination", destination),
            detailRow("Vehicle", vehicle),
            detailRow("Distance", distance),
            detailRow("ETA", time),
            const Divider(height: 25),
            detailRow("Fare", fare),
          ],
        ),
      ),
    );
  }
}
