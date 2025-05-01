import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/build_rich_text.dart';
import 'package:zyft/view_models/location_view_model.dart';

class InitialRideDetails extends ConsumerWidget {
  const InitialRideDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Theme.of(context).highlightColor)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (locationState.pickupName != null)
              BuildRichText(
                title: 'Pickup:',
                subtitle: locationState.pickupName!.toString(),
              ),
            SizedBox(height: 8),
            if (locationState.destinationName != null)
              BuildRichText(
                title: 'Drop off:',
                subtitle: locationState.destinationName!.toString(),
              ),

            const SizedBox(height: 8),
            if (locationState.pickupLocation != null &&
                locationState.dropoffLocation != null)
              BuildRichText(
                title: 'Distance:',
                subtitle:
                    '${ref.read(locationProvider.notifier).calculateDistance(locationState.pickupLocation!, locationState.dropoffLocation!).toStringAsFixed(2)} km',
              ),
          ],
        ),
      ),
    );
  }
}
