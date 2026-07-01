import 'dart:convert';

import 'package:http/http.dart' as http;

class GeocodingService {
  static Future<String?> getAddress(
    double latitude,
    double longitude,
  ) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/reverse"
      "?lat=$latitude&lon=$longitude&format=jsonv2",
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "AnsarTaxi",
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    return data["display_name"];
  }
}
