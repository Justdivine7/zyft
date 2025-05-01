import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/app_widgets/initial_ride_details.dart';
import 'package:zyft/constants/app_widgets/input_text_field.dart';
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
  bool isSelectingPickup = true;
  bool initialRideDetails = false;
  List<String> tripProgressChips = ['1', '2', '3', '4'];
  // bool showChips = false;
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
    final currentStep = ref.watch(currentStepProvider);
    final showChips = ref.watch(showChipsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SingleChildScrollView(scrollDirection: Axis.horizontal),
        // backgroundColor: Colors.white,
      ),

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
                          top: 10,
                          left: 0,
                          right: 0,
                          child: Visibility(
                            visible: showChips,
                            child: Container(
                              height: size.height * 0.12,

                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print('Back button pressed');

                                      setState(() {
                                        ref
                                            .read(showChipsProvider.notifier)
                                            .state = false;
                                      });
                                      Navigator.pop(context);
                                    },

                                    icon: Icon(Icons.arrow_back),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children:
                                          tripProgressChips.asMap().entries.map(
                                            (entry) {
                                              final index = entry.key;
                                              final progress = entry.value;
                                              final isCompleted =
                                                  index < currentStep;
                                              final isActive =
                                                  index == currentStep;
                                              Color backgroundColor =
                                                  Colors.white;
                                              Color textColor = Colors.black;

                                              if (isActive) {
                                                backgroundColor =
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor;
                                              } else if (isCompleted) {
                                                backgroundColor = Colors.black;
                                                textColor = Colors.white;
                                              } else {
                                                backgroundColor =
                                                    Theme.of(
                                                      context,
                                                    ).shadowColor;
                                                textColor = Colors.black;
                                              }
                                              return Chip(
                                                elevation: 2,
                                                label: Text(
                                                  progress,
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                labelPadding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 10,
                                                    ),

                                                backgroundColor:
                                                    backgroundColor,
                                              );
                                            },
                                          ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.005,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Visibility(
                                visible: _suggestions.isEmpty ? false : true,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _suggestions.length,
                                    itemBuilder: (context, index) {
                                      final suggestion = _suggestions[index];
                                      return ListTile(
                                        title: Text(suggestion['description']!),
                                        onTap: () async {
                                          await ref
                                              .read(locationProvider.notifier)
                                              .selectPlace(
                                                suggestion['placeId']!,
                                                isSelectingPickup,
                                                suggestion['description']!,
                                              );
                                          if (isSelectingPickup) {
                                            _pickupController.text =
                                                suggestion['description']!;
                                          } else {
                                            _dropoffController.text =
                                                suggestion['description']!;
                                            ref
                                                .read(locationProvider.notifier)
                                                .fetchRouteBetweenPickupAndDestination();
                                          }
                                          setState(() {
                                            _suggestions = [];
                                            _pickupController.clear();
                                            _dropoffController.clear();
                                          });
                                        },
                                      );
                                    },
                                  ),
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
                            inputController: _pickupController,
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
                            hintText: 'From',
                            prefixIcon: Image.asset('assets/images/pickup.png'),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          SizedBox(height: size.height * 0.01),

                          InputTextField(
                            inputController: _dropoffController,
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
                            hintText: 'To',
                            prefixIcon: Image.asset(
                              'assets/images/destination.png',
                            ),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                          if (initialRideDetails) InitialRideDetails(),
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

                                  showTripDetailsSheet(context);

                                  ref.read(currentStepProvider.notifier).state =
                                      1;
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
