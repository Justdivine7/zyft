import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState {
  final LatLng? currentLocation;
  final bool isLoading;
  final String? error;
  final List<LatLng>? polylinePoints;
  final LatLng? pickupLocation;
  final LatLng? dropoffLocation;
  final double? distance;
  final String? pickupName;
  final String? destinationName;

  const LocationState({
    this.currentLocation,
    this.isLoading = true,
    this.error,
    this.polylinePoints,
    this.pickupLocation,
    this.dropoffLocation,
    this.distance,
    this.pickupName,
    this.destinationName,
  });

  LocationState copyWith({
    LatLng? currentLocation,
    bool? isLoading,
    String? error,
    List<LatLng>? polylinePoints,
    LatLng? pickupLocation,
    LatLng? dropoffLocation,
    double? distance,
    String? pickupName,
    String? destinationName,
  }) {
    return LocationState(
      currentLocation: currentLocation ?? this.currentLocation,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      polylinePoints: polylinePoints ?? this.polylinePoints,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      distance: distance ?? this.distance,
      pickupName: pickupName ?? this.pickupName,
      destinationName: destinationName ?? this.destinationName,
    );
  }
}
