import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/app_widgets/trip_list_tile.dart';
import 'package:zyft/view_models/location_view_model.dart';

class MakePaymentSheet extends ConsumerWidget {
  final VoidCallback onNext;
  const MakePaymentSheet({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make payment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              // color: Theme.of(context).highlightColor,
            ),
          ),
          TripListTile(
            title: 'Pick up',
            subtitle: locationState.pickupName.toString(),
            icon: Icons.location_on,
            iconSize: 24,
          ),

          TripListTile(
            title: 'Drop off',
            subtitle: locationState.destinationName.toString(),
            icon: Icons.location_on,
            iconSize: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    '${ref.read(locationProvider.notifier).calculateDistance(locationState.pickupLocation!, locationState.dropoffLocation!).toStringAsFixed(2)} km',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: size.width * 0.01),

                  Text(
                    '10 mins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.attach_money_outlined),
                  SizedBox(width: size.width * 0.01),

                  Text(
                    '\$50',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppButton(
                  label: 'On spot',
                  color: Colors.white,
                  onTap: () {},
                  textColor: Colors.black,
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 3,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.15),
              Expanded(
                child: AppButton(
                  label: 'Continue',
                  color: Theme.of(context).indicatorColor,
                  onTap: onNext,
                  textColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).indicatorColor,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
