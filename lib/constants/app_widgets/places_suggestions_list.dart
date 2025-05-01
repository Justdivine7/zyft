import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/view_models/location_view_model.dart';

class PlacesSuggestionsList extends ConsumerWidget {
  final List suggestions;
  final TextEditingController pickupController;
  final TextEditingController dropoffController;
  final bool isSelectingPickup;
  final VoidCallback onSuggestionSelected;

  const PlacesSuggestionsList(
    this.suggestions,
    this.pickupController,
    this.dropoffController,
    this.isSelectingPickup,
    this.onSuggestionSelected, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
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
                pickupController.text = suggestion['description']!;
              } else {
                dropoffController.text = suggestion['description']!;
                ref
                    .read(locationProvider.notifier)
                    .fetchRouteBetweenPickupAndDestination();
              }
              onSuggestionSelected();
            },
          );
        },
      ),
    );
  }
}
