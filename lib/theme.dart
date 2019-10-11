/**
 * Custom theme
 */
import 'package:flutter/material.dart';

final ThemeData randomRunThemeData = ThemeData(
  primaryColor: RandomRunColors.brightPink,
  fontFamily: 'Montserrat',
);

final Text appBar = Text(
  'Random Run',
  style: TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSize.small,
    fontWeight: FontWeight.w600,
  ),
);

class RandomRunColors {
  static const Color brightPink = const Color(0xFFFF4F4F);
  static const Color lighterPink = const Color(0xFFFF7272);
  static const Color grayPink = const Color(0xFFFAF5F5);
  static const Color disabled = const Color(0xFFE0E0E0);
}

class Spacing {
  static const double micro = 10.0;
  static const double small = 20.0;
  static const double medium = 60.0;
  static const double mediumLarge = 72.0;
  static const double large = 100.0;
  static const double xlarge = 200.0;
  static const double xxlarge = 300.0;
}

class FontSize {
  static const double small = 24.0;
  static const double medium = 30.0;
  static const double large = 40.0;
  static const double xlarge = 72.0;
}
