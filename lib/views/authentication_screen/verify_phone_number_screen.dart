import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/views/main_screens/app_screen.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(forceMaterialTransparency: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).indicatorColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset('assets/images/mail-icon.png'),
                  ),
                ),
                // SizedBox(height: size.height * 0.02),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 24),
                    children: const [
                      TextSpan(text: 'Verification '),
                      TextSpan(
                        text: 'Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                Text.rich(
                  TextSpan(
                    text: 'Please enter the ',
                    style: TextStyle(color: Theme.of(context).highlightColor),
                    children: [
                      TextSpan(
                        text: '4-digits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' sent \nto your phone number',
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),

                SizedBox(
                  width: size.width * 0.6,
                  child: PinCodeTextField(
                    
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      selectedColor: Theme.of(context).indicatorColor,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: size.height * 0.05),

                SizedBox(
                  width: size.width * 0.6,
                  child: AppButton(
                    label: 'Continue',
                    color: Theme.of(context).indicatorColor,
                    textColor: Colors.white,
                    onTap:
                        () => Navigator.of(context).pushReplacement(
                          
                          (MaterialPageRoute(
                            builder: (context) => AppScreen(),
                          )),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
