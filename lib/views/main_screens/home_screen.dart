import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
// import 'package:zyft/constants/app_widgets/home_app_bar.dart';
import 'package:zyft/constants/app_widgets/input_text_field.dart';
import 'package:zyft/constants/app_widgets/places_suggestions_list.dart';
import 'package:zyft/view_models/location_view_model.dart';
import 'package:zyft/view_models/map_controller_view_model.dart';
import 'package:zyft/views/bottom_sheets/botttom_sheet_main_page.dart';

final currentStepProvider = StateProvider<int>((ref) => 1);
final showChipsProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const LatLng _googleOffice = LatLng(37.4223, -122.0848);
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final FocusNode _pickupFocusNode= FocusNode();
    final FocusNode _dropoffFocusNode= FocusNode();

  bool isSelectingPickup = true;
  bool initialRideDetails = false;
  List<String> tripProgressChips = ['1', '2', '3', '4'];

  List<Map<String, String>> _suggestions = [];

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final locationState = ref.watch(locationProvider);
    final mapController = ref.watch(mapControllerProvider.notifier);
    // final showChips = ref.watch(showChipsProvider);

    return Scaffold(
      
      // appBar:
      //     showChips
      //         ? AppBar(
      //           automaticallyImplyLeading: false,
      //           forceMaterialTransparency: true,
      //           toolbarHeight: size.height * 0.12,

      //           elevation: 2,
      //           title: HomeAppBar(tripProgressChips),
      //         )
      //         : null,
      body:
          locationState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: (GoogleMapController controller) {
                            mapController.setController(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target:
                                locationState.currentLocation ?? _googleOffice,
                            zoom: 14,
                          ),
                          polylines: {
                            if (locationState.polylinePoints != null)
                              Polyline(
                                polylineId: PolylineId("route"),
                                points: locationState.polylinePoints!,
                                color: const Color.fromARGB(255, 70, 4, 223),
                                width: 5,
                              ),
                          },
                          markers: {
                            if (locationState.pickupLocation != null)
                              Marker(
                                markerId: MarkerId('_currentLocation'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue,
                                ),
                                position: locationState.pickupLocation!,

                                infoWindow: InfoWindow(title: 'Pickup'),
                              ),
                            if (locationState.dropoffLocation != null)
                              Marker(
                                markerId: MarkerId('_destinationLocation'),
                                icon: BitmapDescriptor.defaultMarker,
                                position: locationState.dropoffLocation!,
                                infoWindow: InfoWindow(title: 'Destination'),
                              ),
                          },
                        ),

                        Positioned(
                          bottom: size.height * 0.005,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Visibility(
                                visible: _suggestions.isEmpty ? false : true,
                                child: PlacesSuggestionsList(
                                  _suggestions,
                                  _pickupController,
                                  _dropoffController,
                                  isSelectingPickup,
                                  () {
                                    setState(() {
                                      _suggestions = [];
                                      _pickupController.clear();
                                      _dropoffController.clear();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          InputTextField(
                            focusNode: _pickupFocusNode,
                            inputController: _pickupController,
                            textInputAction: TextInputAction.next,
                            onTap: () {
                              setState(() {
                                isSelectingPickup = true;
                              });
                            },
                            onChanged: (value) async {
                              final suggestions = await ref
                                  .read(locationProvider.notifier)
                                  .getPlaceSuggestion(value);
                              setState(() {
                                _suggestions = suggestions;
                                initialRideDetails = true;
                              });
                            },
                            hintText:
                                locationState.pickupName != null
                                    ? locationState.pickupName.toString()
                                    : 'From',
                            prefixIcon: Image.asset('assets/images/pickup.png'),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          SizedBox(height: size.height * 0.01),

                          InputTextField(
                            inputController: _dropoffController,
                            focusNode: _dropoffFocusNode,
                            textInputAction: TextInputAction.done,
                            onTap: () {
                              setState(() {
                                isSelectingPickup = false;
                              });
                            },
                            onChanged: (value) async {
                              final suggestions = await ref
                                  .read(locationProvider.notifier)
                                  .getPlaceSuggestion(value);
                              setState(() {
                                _suggestions = suggestions;
                                initialRideDetails = true;
                              });
                            },
                            hintText:  locationState.destinationName != null
                                    ? locationState.destinationName.toString()
                                    : 'To',
                            prefixIcon: Image.asset(
                              'assets/images/destination.png',
                            ),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          // if (initialRideDetails) InitialRideDetails(),
                          SizedBox(height: size.height * 0.01),
                          if (initialRideDetails == true &&
                              locationState.pickupLocation != null &&
                              locationState.dropoffLocation != null)
                            Center(
                              child: AppButton(
                                textColor: Colors.white,
                                label: 'Proceed',
                                color: Theme.of(context).indicatorColor,
                                onTap: () async {
                                  ref
                                      .watch(locationProvider.notifier)
                                      .clearRideLocations();
                                  setState(() {
                                    initialRideDetails = false;
                                  });
                                  ref.read(showChipsProvider.notifier).state =
                                      true;
                                  ref.read(currentStepProvider.notifier).state =
                                      1;

                                  await showTripDetailsSheet(context);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
