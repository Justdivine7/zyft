import 'package:flutter/material.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/constants/app_widgets/payment_tile.dart';

class SelectPaymentMethodSheet extends StatelessWidget {
  final VoidCallback onNext;

  const SelectPaymentMethodSheet({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          Column(
            children: [
              PaymentTile(
                icon: Icons.attach_money_outlined,
                iconColor: Colors.white,
                title: 'Bank transfer',
                subtile: 'Default Method',
                color: Theme.of(context).indicatorColor,
                activeColor: Colors.white,
                textColor: Colors.white,
                subtitleColor: Colors.white,
              ),
              PaymentTile(
                icon: Icons.account_balance_outlined,
                iconColor: Colors.black,
                title: 'MasterCard',
                subtile: '**** **** **** 1234',
                color: Colors.white,
                activeColor: Colors.black,
                textColor: Colors.black,
                subtitleColor: Theme.of(context).highlightColor,
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
                    Navigator.pop(context);
                  },
                  textColor: Colors.black,
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.15),
              Expanded(
                child: AppButton(
                  label: 'Continue',
                  color: Theme.of(context).indicatorColor,
                  onTap: onNext,
                  textColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).indicatorColor,
                    width: 2,
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
