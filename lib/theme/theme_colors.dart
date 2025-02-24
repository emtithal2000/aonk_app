import 'package:flutter/material.dart';

class ThemeColors {
  static const Color primaryColor = Color(0xff84beb0);
  static const Color accentColor = Color(0xff52b8a0);
  static const Color iconColor = Color(0xff81bdaf);

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : const Color(0xFF2D2D2D);
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF1A1A1A)
        : Colors.white;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF2D2D2D)
        : Colors.white;
  }

  static Color getDialogTitleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? accentColor.withOpacity(0.9)
        : accentColor;
  }
} 