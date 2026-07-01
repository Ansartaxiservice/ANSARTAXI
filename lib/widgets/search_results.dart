import 'package:flutter/material.dart';
import '../models/place_model.dart';

class SearchResults extends StatelessWidget {
  final List<PlaceModel> places;
  final ValueChanged<PlaceModel> onSelected;

  const SearchResults({
    super.key,
    required this.places,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(
        maxHeight: 220,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: places.length,
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        itemBuilder: (context, index) {
          final place = places[index];

          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            title: Text(
              place.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              onSelected(place);
            },
          );
        },
      ),
    );
  }
}
