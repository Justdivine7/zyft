import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/trip_processed.dart';
// import 'package:zyft/view_models/location_view_model.dart';
// import 'package:zyft/constants/app_widgets/home_app_bar.dart';
import 'package:zyft/views/bottom_sheets/make_payment_sheet.dart';
import 'package:zyft/views/bottom_sheets/schedule_time_sheet.dart';
import 'package:zyft/views/bottom_sheets/select_payment_method_sheet.dart';
import 'package:zyft/views/bottom_sheets/trip_details_sheet.dart';
import 'package:zyft/views/main_screens/home_screen.dart';

Future<void> showTripDetailsSheet(BuildContext context) async {
  FocusScope.of(context).unfocus(); // Dismiss keyboard

  await showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,

    barrierColor: Colors.transparent,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder:
        (context) => Consumer(
          builder:
              (context, ref, _) => SizedBox(
                child: DraggableScrollableSheet(
                  minChildSize: 0.4,
                  maxChildSize: 0.5,
                  initialChildSize: 0.4,
                  expand: false,
                  builder:
                      (context, scrollController) => TripDetailsSheet(
                        onNext: () {
                          Navigator.pop(context);
                          ref.read(currentStepProvider.notifier).state = 2;

                          Future.delayed(Duration.zero, () {
                            showScheduleTimePlanSheet(context);
                          });
                        },
                      ),
                ),
              ),
        ),
  );
}

// Future<void> showTripDetailsSheet(BuildContext context) async {
//   await showModalBottomSheet(
//     context: context,
//     barrierColor: Colors.transparent,
//     isScrollControlled: true,
//     builder: (context) => Container(
//       height: MediaQuery.of(context).size.height * 0.2,
//       child: Column(
//         children: [
//           HomeAppBar(['1', '2', '3', '4']), // Test with HomeAppBar
//           Expanded(child: Center(child: Text('Trip Details'))),
//         ],
//       ),
//     ),
//   );
// }
Future<void> showScheduleTimePlanSheet(BuildContext context) async {
  FocusScope.of(context).unfocus(); // Dismiss keyboard

  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,

    isScrollControlled: true,
    barrierColor: Colors.transparent,

    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder:
        (context) => Consumer(
          builder:
              (context, ref, _) => SizedBox(
                child: DraggableScrollableSheet(
                  minChildSize: 0.38,
                  maxChildSize: 0.5,
                  initialChildSize: 0.38,
                  expand: false,
                  builder:
                      (context, scrollController) => ScheduleTimeSheet(
                        onNext: () {
                          Navigator.pop(context);
                          Future.delayed(Duration.zero, () {
                            showSelectPaymentSheet(context);
                          });
                          ref.read(currentStepProvider.notifier).state = 3;
                        },
                      ),
                ),
              ),
        ),
  );
}

Future<void> showSelectPaymentSheet(BuildContext context) async {
  FocusScope.of(context).unfocus(); // Dismiss keyboard

  await showModalBottomSheet(
    barrierColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,

    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: context,
    builder:
        (context) => Consumer(
          builder:
              (context, ref, _) => SizedBox(
                child: DraggableScrollableSheet(
                  minChildSize: 0.4,
                  maxChildSize: 0.7,
                  initialChildSize: 0.4,
                  expand: false,
                  builder:
                      (context, scrollController) => SelectPaymentMethodSheet(
                        onNext: () {
                          Navigator.pop(context);
                          Future.delayed(Duration.zero, () {
                            showMakePaymentSheet(context);
                          });
                          ref.read(currentStepProvider.notifier).state = 4;
                        },
                      ),
                ),
              ),
        ),
  );
}

Future<void> showMakePaymentSheet(BuildContext context) async {
  FocusScope.of(context).unfocus(); // Dismiss keyboard

  await showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,

    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: context,
    builder:
        (context) => Consumer(
          builder:
              (context, ref, _) => SizedBox(
                child: DraggableScrollableSheet(
                  minChildSize: 0.4,
                  maxChildSize: 0.7,
                  initialChildSize: 0.4,
                  expand: false,
                  builder:
                      (context, scrollController) => MakePaymentSheet(
                        onNext: () {
                          // Navigator.pop(context);
                          showDriverOnWayDialog(context);
                        },
                      ),
                ),
              ),
        ),
  );
}
