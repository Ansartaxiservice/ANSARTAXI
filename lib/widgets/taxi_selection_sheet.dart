import 'package:flutter/material.dart';

class TaxiSelectionSheet extends StatelessWidget {
  const TaxiSelectionSheet({super.key});

  Widget taxiCard({
    required IconData icon,
    required String name,
    required String seats,
    required String eta,
    required String fare,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.yellow.shade100,
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "$seats • $eta",
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fare,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Select",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            "Choose Your Ride",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          taxiCard(
            icon: Icons.local_taxi,
            name: "Mini",
            seats: "4 Seats",
            eta: "2 min away",
            fare: "₹316",
          ),

          taxiCard(
            icon: Icons.directions_car,
            name: "Sedan",
            seats: "4 Seats",
            eta: "4 min away",
            fare: "₹420",
          ),

          taxiCard(
            icon: Icons.airport_shuttle,
            name: "SUV",
            seats: "6 Seats",
            eta: "5 min away",
            fare: "₹590",
          ),

          taxiCard(
            icon: Icons.airport_shuttle,
            name: "XL",
            seats: "7 Seats",
            eta: "8 min away",
            fare: "₹890",
          ),
        ],
      ),
    );
  }
}
