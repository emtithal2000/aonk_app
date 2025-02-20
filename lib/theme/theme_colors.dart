import 'package:flutter/material.dart';

class ThemeColors {
  static const Color primaryColor = Color(0xff84beb0);
  static const Color accentColor = Color(0xff52b8a0);
  static const Color iconColor = Color(0xff81bdaf);

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.grey[900]! 
        : Colors.white;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.grey[800]! 
        : Colors.white;
  }
} 