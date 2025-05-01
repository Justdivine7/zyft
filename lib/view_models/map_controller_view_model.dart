import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControllerViewModel extends StateNotifier<GoogleMapController?> {
  MapControllerViewModel() : super(null);

  void setController(GoogleMapController controller) {
    state = controller;
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}

final mapControllerProvider =
    StateNotifierProvider<MapControllerViewModel, GoogleMapController?>(
      (ref) => MapControllerViewModel(),
    );
