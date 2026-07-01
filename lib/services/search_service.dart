import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/place_model.dart';

class SearchService {
  static Future<List<PlaceModel>> search(String query) async {
    if (query.trim().isEmpty) return [];

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
      "?q=$query,Goa,India"
      "&format=jsonv2"
      "&limit=5",
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "AnsarTaxi",
      },
    );

    if (response.statusCode != 200) {
      return [];
    }

    final List data = jsonDecode(response.body);

    return data
        .map((e) => PlaceModel.fromJson(e))
        .toList();
  }
}
