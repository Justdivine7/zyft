import 'package:flutter/material.dart';

class PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtile;
  final Color color;
  final Color activeColor;
  final Color textColor;
  final Color iconColor;
  final Color subtitleColor;
  const PaymentTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtile,
    required this.color,
    required this.activeColor,
    required this.textColor,
    required this.iconColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        tileColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(icon, color: iconColor,),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtile,
          style: TextStyle(color: subtitleColor, fontSize: 16),
        ),
        trailing: Radio(
          value: true,
          onChanged: (value) {},
          groupValue: true,

          activeColor: activeColor,
        ),
      ),
    );
  }
}
