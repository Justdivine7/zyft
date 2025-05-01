import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/app_widgets/trip_list_tile.dart';
import 'package:zyft/view_models/location_view_model.dart';

class TripDetailsSheet extends ConsumerWidget {
  final VoidCallback onNext;

  const TripDetailsSheet({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Create a trip',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          TripListTile(
            title: 'Pick up',
            subtitle: locationState.pickupName.toString(),
            icon: Icons.location_on,
            iconSize: 24,
          ),

          TripListTile(
            title: 'Distance',
            subtitle:
                '${ref.read(locationProvider.notifier).calculateDistance(locationState.pickupLocation!, locationState.dropoffLocation!).toStringAsFixed(2)} km',
            icon: Icons.circle,
            iconSize: 20,
          ),

          TripListTile(
            title: 'Drop off',
            subtitle: locationState.destinationName.toString(),
            icon: Icons.location_on,
            iconSize: 24,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: AppButton(
                textColor: Colors.white,
                label: 'Create a trip',
                color: Theme.of(context).indicatorColor,
                onTap: onNext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
