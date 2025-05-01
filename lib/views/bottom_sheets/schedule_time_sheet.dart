import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/functions/functions.dart';

class ScheduleTimeSheet extends ConsumerWidget {
  final VoidCallback onNext;
  const ScheduleTimeSheet({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trip',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'change',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Schedule Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Chip(
                    label: Text('Now'),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: size.width * 0.035),
                  Chip(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),

                    label: Icon(Icons.access_time, color: Colors.white),
                    backgroundColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          Text(
            'As soon as possible',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).highlightColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Plan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Radio(
                value: false,
                onChanged: (value) {},
                groupValue: false,
                activeColor: Theme.of(context).indicatorColor,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppButton(
                  label: 'Cancel',
                  color: Colors.white,
                  onTap: () {
                    dismissChipsAndModal(context, ref);
                  },
                  textColor: Colors.black,
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 3,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.15),
              Expanded(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: AppButton(
                    label: 'Continue',
                    color: Theme.of(context).indicatorColor,
                    onTap: onNext,
                    textColor: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).indicatorColor,
                      width: 3,
                    ),
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
