import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/functions/functions.dart';

void showDriverOnWayDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button
    builder: (_) => const TripProcessed(),
  );
}

class TripProcessed extends ConsumerWidget {
  const TripProcessed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration at top
            Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/driving-car.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              'Good news!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),

            Text(
              'Your driver is on the way.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Ok',
                color: Theme.of(context).indicatorColor,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  dismissChipsAndModal(context, ref);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
