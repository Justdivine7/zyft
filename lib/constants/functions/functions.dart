import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/views/main_screens/home_screen.dart';

void dismissChipsAndModal(BuildContext context, WidgetRef ref) {
  ref.read(showChipsProvider.notifier).state = false;
  ref.read(currentStepProvider.notifier).state = 1;

  if (Navigator.of(context).canPop()) {
    Navigator.pop(context);
  }
}
