import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/views/bottom_sheets/make_payment_sheet.dart';
import 'package:zyft/views/bottom_sheets/schedule_time_sheet.dart';
import 'package:zyft/views/bottom_sheets/select_payment_method_sheet.dart';
import 'package:zyft/views/bottom_sheets/trip_details_sheet.dart';
import 'package:zyft/views/main_screens/home_screen.dart';

Future<void> showTripDetailsSheet(BuildContext context,) {
 return showModalBottomSheet(
    isScrollControlled: true,
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
                          showScheduleTimePlanSheet(context);
                        },
                      ),
                ),
              ),
        ),
  );
}

void showScheduleTimePlanSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
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
                          showSelectPaymentSheet(context);
                          ref.read(currentStepProvider.notifier).state = 3;
                        },
                      ),
                ),
              ),
        ),
  );
}

void showSelectPaymentSheet(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.transparent,

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
                          showMakePaymentSheet(context);
                          ref.read(currentStepProvider.notifier).state = 4;
                        },
                      ),
                ),
              ),
        ),
  );
}

void showMakePaymentSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.transparent,

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
                          Navigator.pop(context);
                          ref.read(currentStepProvider.notifier).state = 3;
                        },
                      ),
                ),
              ),
        ),
  );
}
