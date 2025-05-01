import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zyft/views/main_screens/home_screen.dart';
import 'package:zyft/views/main_screens/profile_screen.dart';
import 'package:zyft/views/main_screens/trips_screen.dart';

class AppScreen extends ConsumerStatefulWidget {
  const AppScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppScreenState();
}

class _AppScreenState extends ConsumerState<AppScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = const [HomeScreen(), TripsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: Colors.transparent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),

        onTap: onItemTapped,
        items: [
          buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
          buildNavItem(index: 1, icon: Icons.drive_eta_rounded, label: 'Trips'),
          buildNavItem(index: 2, icon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    bool isSelected = selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Theme.of(context).indicatorColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size:30,
              color:
                  isSelected ? Colors.white : Theme.of(context).highlightColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected
                      ? Theme.of(context).indicatorColor
                      : Theme.of(context).highlightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
