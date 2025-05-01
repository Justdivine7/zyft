import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/constants/functions/functions.dart';
import 'package:zyft/views/main_screens/home_screen.dart';

class HomeAppBar extends ConsumerWidget {
  final List tripProgressChips;
  const HomeAppBar(this.tripProgressChips, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);

    return Container(
      padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          GestureDetector(
            onTap: () {
             dismissChipsAndModal(context, ref);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children:
                tripProgressChips.asMap().entries.map((entry) {
                  final index = entry.key;
                  final progress = entry.value;
                  final isCompleted = index < (currentStep - 1);
                  final isActive = index == (currentStep - 1);
                  Color backgroundColor = Colors.white;
                  Color textColor = Colors.black;

                  if (isActive) {
                    backgroundColor = Theme.of(context).indicatorColor;
                    textColor = Colors.white;
                  } else if (isCompleted) {
                    backgroundColor = Colors.black;
                    textColor = Colors.white;
                  } else {
                    backgroundColor = Theme.of(context).shadowColor;
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
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),

                    backgroundColor: backgroundColor,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
