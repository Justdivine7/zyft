import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _locationController;
  LocationService({Location? locationController})
    : _locationController = locationController ?? Location();

  Future<bool> _checkAndRequestService() async {
    final serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      final enabled = await _locationController.requestService();
      return enabled;
    }
    return true;
  }

  Future<bool> _checkAndRequestPermission() async {
    var permission = await _locationController.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _locationController.requestPermission();
      return permission == PermissionStatus.granted;
    }
    return permission == PermissionStatus.granted;
  }

  Future<Stream<LatLng>> getLocationUpdates() async {
    try {
      final serviceEnabled = await _checkAndRequestService();
      if (!serviceEnabled) {
        throw Exception("Please enable location services");
      }
      final permissionGranted = await _checkAndRequestPermission();
      if (!permissionGranted) {
        throw Exception("Location permisson denied");
      }
      return _locationController.onLocationChanged.map((data) {
        if (data.latitude != null && data.longitude != null) {
          return LatLng(data.latitude!, data.longitude!);
        }
        throw Exception("Invalid location data");
      });
    } catch (e) {
      throw Exception("Error accessing location: $e");
    }
  }
}
