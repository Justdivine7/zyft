import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:zyft/models/location_state.dart';
import 'package:zyft/providers/global_providers.dart';
import 'package:zyft/services/location_service.dart';
import 'package:zyft/view_models/map_controller_view_model.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  final LocationService _locationService;
  final Ref _ref;
  StreamSubscription<LatLng>? _locationSubscription;

  LocationViewModel(this._locationService, this._ref)
    : super(const LocationState()) {
    _init();
  }
  final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  Future<void> _init() async {
    try {
      final locationStream = await _locationService.getLocationUpdates();
      _locationSubscription = locationStream.listen(
        (LatLng newLocation) {
          state = state.copyWith(
            currentLocation: newLocation,
            isLoading: false,
            error: null,
          );
          // _ref
          //     .read(mapControllerProvider)
          //     ?.animateCamera(CameraUpdate.newLatLng(newLocation));
        },
        onError: (e) {
          state = state.copyWith(isLoading: false, error: e.toString());
          // _showSnackBar(e.toString());
          if (kDebugMode) {
            print(e.toString());
          }
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // _showSnackBar(e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<LatLng>> getPolylinePoints(
    double originLatitude,
    double originLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      googleApiKey: apiKey,
      request: PolylineRequest(
        origin: PointLatLng(originLatitude, originLongitude),
        destination: PointLatLng(destinationLatitude, destinationLongitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      if (kDebugMode) {
        print(polylineCoordinates);
      }
    }
    return polylineCoordinates;
  }

  Future<void> fetchRoute(LatLng destination) async {
    if (state.currentLocation == null) {
      return;
    }
    try {
      final polylinePoints = await getPolylinePoints(
        state.currentLocation!.latitude,
        state.currentLocation!.longitude,
        destination.latitude,
        destination.longitude,
      );
      state = state.copyWith(polylinePoints: polylinePoints, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      _showSnackBar('polyline error');
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<Map<String, String>>> getPlaceSuggestion(String query) async {
    return await _ref
        .read(placeServiceProvider)
        .getPlaceSuggestions(query, Uuid().v4());
  }

  Future<void> selectPlace(
    String placeId,
    bool isPickup,
    String description,
  ) async {
    try {
      final location = await _ref
          .read(placeServiceProvider)
          .getPlaceLocation(placeId);
      if (isPickup) {
        state = state.copyWith(
          pickupLocation: location,
          pickupName: description,
        );
      } else {
        state = state.copyWith(
          dropoffLocation: location,
          destinationName: description,
        );
      }
      _ref
          .read(mapControllerProvider)
          ?.animateCamera(CameraUpdate.newLatLng(location));
    } catch (e) {
      state = state.copyWith(error: e.toString());
      _showSnackBar(e.toString());
    }
  }

  double calculateDistance(LatLng start, LatLng end) {
    const earthRadius = 6371; // Earth's radius in km
    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLng = _degreesToRadians(end.longitude - start.longitude);
    final a =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            (sin(dLng / 2) * sin(dLng / 2));
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c; // distance in kilometers
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<void> fetchRouteBetweenPickupAndDestination() async {
    if (state.pickupLocation == null || state.dropoffLocation == null) {
      _showSnackBar("Please select both pickup and destination");
      return;
    }
    try {
      final polylinePoints = await getPolylinePoints(
        state.pickupLocation!.latitude,
        state.pickupLocation!.longitude,
        state.dropoffLocation!.latitude,
        state.dropoffLocation!.longitude,
      );
      state = state.copyWith(polylinePoints: polylinePoints, error: null);
      final distance = calculateDistance(
        state.pickupLocation!,
        state.dropoffLocation!,
      );
      // print('Distance: ${distance.toStringAsFixed(2)} km');
      if (kDebugMode) {
        print('Distance: ${distance.toStringAsFixed(2)} km');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
      // print('Failed to fetch route:${e.toString()}');
      // print('StackTrace: $stackTrace');

      _showSnackBar('Failed to fetch route');
    }
  }

  void clearRideLocations() {
    state = state.copyWith(
      pickupLocation: null,
      dropoffLocation: null,
      polylinePoints: [],
    );
  }

  void _showSnackBar(String message) {
    _ref
        .read(scaffoldMessengerKeyProvider)
        .currentState
        ?.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }
}

final locationProvider =
    StateNotifierProvider<LocationViewModel, LocationState>(
      (ref) => LocationViewModel(LocationService(), ref),
    );
