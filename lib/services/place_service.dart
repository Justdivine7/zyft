import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  static const String baseUrl = 'https://places.googleapis.com/v1';
  Future<List<Map<String, String>>> getPlaceSuggestions(
    String query,
    String sessionToken,
  ) async {
    
    if (query.isEmpty) return [];
    final response = await http.post(
      Uri.parse('$baseUrl/places:autocomplete'),
      headers: {'Content-Type': 'application/json', 'X-Goog-Api-Key': apiKey},
      body: jsonEncode({'input': query, 'sessionToken': sessionToken}),
    );

    // print('Status Code: ${response.statusCode}'); // Debugging
    // print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List.from(data['suggestions'] ?? [])
          .map(
            (s) => {
              'placeId': s['placePrediction']['placeId'] as String,
              'description': s['placePrediction']['text']['text'] as String,
            },
          )
          .toList();
    } else {
      print('error occured');
    }
    return [];
  }

  Future<LatLng> getPlaceLocation(String placeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/places/$placeId?fields=location'),
      headers: {'X-Goog-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      
      final data = jsonDecode(response.body);
      // print('Selected:$data');
      final location = data['location'];
      return LatLng(location['latitude'], location['longitude']);
          

    }
    throw Exception('Failed to fetch place location');
    
  }
}
