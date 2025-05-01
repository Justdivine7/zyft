import 'package:flutter/material.dart';

class TripListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final double iconSize;
  const TripListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
       child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).canvasColor, size: iconSize),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(subtitle, ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
