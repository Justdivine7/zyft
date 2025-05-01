import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:zyft/constants/app_widgets/app_button.dart';
import 'package:zyft/views/authentication_screen/verify_phone_number_screen.dart';

class InputPhoneNumberScreen extends StatefulWidget {
  const InputPhoneNumberScreen({super.key});

  @override
  State<InputPhoneNumberScreen> createState() => _InputPhoneNumberScreenState();
}

class _InputPhoneNumberScreenState extends State<InputPhoneNumberScreen> {
  Country _selectedCountry = Country.parse("US"); // default to Nigeria
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: size.height * 0.35,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.height * 0.16),
                        bottomRight: Radius.circular(size.height * 0.16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Image.asset('assets/images/car.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 16,
              right: 16,
            ),
            child: SizedBox(
              height: size.height * 0.46,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),

                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Welcome to',
                              style: TextStyle(fontSize: 32),
                            ),
                            TextSpan(
                              text: ' Zyft',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).highlightColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Local Rides,',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextSpan(
                              text: ' Local Drivers,',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextSpan(
                              text: ' Local Trust.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(left: 30),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                      
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            onSelect: (Country country) {
                              setState(() {
                                _selectedCountry = country;
                              });
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_down_rounded),
                            Text(
                              '+${_selectedCountry.phoneCode}  ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),

                      hintText: 'Enter your number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: Theme.of(context).shadowColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: Theme.of(context).shadowColor,
                          width: 2,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  SizedBox(
                    width: size.width * 0.55,
                    child: AppButton(
                      label: 'Get started',
                      color: Theme.of(context).indicatorColor,
                      textColor: Colors.white,
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyPhoneNumberScreen(),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
