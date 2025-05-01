import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/services/place_service.dart';
import 'package:zyft/services/travel_time_service.dart';

final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

final scaffoldMessengerKeyProvider =
    Provider<GlobalKey<ScaffoldMessengerState>>(
      (ref) => GlobalKey<ScaffoldMessengerState>(),
    );

final placeServiceProvider = Provider<PlaceService>((ref) => PlaceService());

final travelTimeServiceProvider = Provider((ref) => TravelTimeService(apiKey));

final travelTimeProvider = FutureProvider.family<Duration, Map<String, double>>(
  (ref, coords) async {
    final service = ref.read(travelTimeServiceProvider);
    return await service.getTravelTime(
      startLat: coords['startLat']!,
      startLng: coords['startLng']!,
      endLat: coords['endLat']!,
      endLng: coords['endLng']!,
    );
  },
);
