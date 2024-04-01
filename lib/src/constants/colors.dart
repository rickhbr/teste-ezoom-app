import 'package:flutter/material.dart';

Map<int, Color> _accentColor = {
  50: const Color.fromRGBO(55, 135, 235, 0.1),
  100: const Color.fromRGBO(55, 135, 235, 0.2),
  200: const Color.fromRGBO(55, 135, 235, 0.3),
  300: const Color.fromRGBO(55, 135, 235, 0.4),
  400: const Color.fromRGBO(55, 135, 235, 0.5),
  500: const Color.fromRGBO(55, 135, 235, 0.6),
  600: const Color.fromRGBO(55, 135, 235, 0.7),
  700: const Color.fromRGBO(55, 135, 235, 0.8),
  800: const Color.fromRGBO(55, 135, 235, 0.9),
  900: const Color.fromRGBO(55, 135, 235, 1.0),
};

Map<int, Color> _primaryColor = {
  50: const Color.fromRGBO(55, 135, 235, 0.1),
  100: const Color.fromRGBO(55, 135, 235, 0.2),
  200: const Color.fromRGBO(55, 135, 235, 0.3),
  300: const Color.fromRGBO(55, 135, 235, 0.4),
  400: const Color.fromRGBO(55, 135, 235, 0.5),
  500: const Color.fromRGBO(55, 135, 235, 0.6),
  600: const Color.fromRGBO(55, 135, 235, 0.7),
  700: const Color.fromRGBO(55, 135, 235, 0.8),
  800: const Color.fromRGBO(55, 135, 235, 0.9),
  900: const Color.fromRGBO(55, 135, 235, 1.0),
};

abstract class CustomColors {
  static MaterialColor customPrimaryColor =
      MaterialColor(0XFF3787EB, _primaryColor);

  static MaterialColor customAccentColor =
      MaterialColor(0XFF3787EB, _accentColor);

  static Color white = const Color(0xffffffff);

  static Color primaryColor = const Color(0XFF3787EB);
  static Color secundaryColor = const Color(0XFF22293D);
  static Color terciaryColor = const Color(0XFFFF5A00);
  static Color blackColor = const Color(0XFF000000);
  static Color whiteColor = const Color(0XFFFFFFFF);

  static Color errorBackgroundColor = const Color(0xFFF44336);
  static Color errorTextColor = const Color.fromARGB(255, 105, 34, 29);

  static Color successBackgroundColor = const Color(0xFF4CAF50);
  static Color successTextColor = const Color.fromARGB(255, 20, 54, 21);
}
