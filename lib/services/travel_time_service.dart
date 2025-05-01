import 'dart:convert';
 import 'package:http/http.dart' as http;

class TravelTimeService {
  final String apiKey;

  TravelTimeService(this.apiKey);

  Future<Duration> getTravelTime({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
    String mode = 'driving', // or walking, bicycling, transit
  }) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=$startLat,$startLng'
      '&destination=$endLat,$endLng'
      '&mode=$mode'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    final data = json.decode(response.body);
    if (data['status'] != 'OK') throw Exception('Failed to get directions');

    final durationSeconds = data['routes'][0]['legs'][0]['duration']['value'];
    return Duration(seconds: durationSeconds);
  }
}
