import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import 'package:zyft/constants/theme/theme_data.dart';
import 'package:zyft/providers/global_providers.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:zyft/views/main_screens/app_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');

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

      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Zyft ride app',
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/images/zyft-logo.png'),
        nextScreen: AppScreen(),
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Color(0xFF0175DC)
      ),
    );
  }
}
