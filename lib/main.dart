import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zyft/constants/theme/theme_data.dart';
import 'package:zyft/providers/global_providers.dart';

import 'package:zyft/views/authentication_screen/input_phone_number_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  // await Future.delayed(Duration(seconds: 2));
  // FlutterNativeSplash.remove();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: ProviderScope.containerOf(
        context,
      ).read(scaffoldMessengerKeyProvider),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,

      // darkTheme: darkTheme,
      // themeMode: ThemeMode.system,
      title: 'Zyft ride app',
      home: InputPhoneNumberScreen(),
    );
  }
}
