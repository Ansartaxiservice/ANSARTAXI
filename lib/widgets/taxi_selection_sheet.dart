import 'package:flutter/material.dart';

class TaxiSelectionSheet extends StatefulWidget {
  const TaxiSelectionSheet({super.key});

  @override
  State<TaxiSelectionSheet> createState() =>
      _TaxiSelectionSheetState();
}

class _TaxiSelectionSheetState
    extends State<TaxiSelectionSheet> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> taxis = [
    {
      "name": "Mini",
      "icon": Icons.local_taxi,
      "seats": "4 Seats",
      "eta": "2 min away",
      "fare": 316,
    },
    {
      "name": "Sedan",
      "icon": Icons.directions_car,
      "seats": "4 Seats",
      "eta": "4 min away",
      "fare": 420,
    },
    {
      "name": "SUV",
      "icon": Icons.airport_shuttle,
      "seats": "6 Seats",
      "eta": "5 min away",
      "fare": 590,
    },
    {
      "name": "XL",
      "icon": Icons.airport_shuttle,
      "seats": "7 Seats",
      "eta": "8 min away",
      "fare": 890,
    },
  ];

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
      child: SafeArea(
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

            const SizedBox(height: 20),ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: taxis.length,
              itemBuilder: (context, index) {
                final taxi = taxis[index];
                final selected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.yellow.shade100
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? Colors.amber
                            : Colors.grey.shade300,
                        width: selected ? 3 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.yellow.shade200,
                          child: Icon(
                            taxi["icon"],
                            color: Colors.black,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                taxi["name"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "${taxi["seats"]} • ${taxi["eta"]}",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Text(
                              "₹${taxi["fare"]}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(height: 6),

                            if (selected)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, taxis[selectedIndex]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Confirm ${taxis[selectedIndex]["name"]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
