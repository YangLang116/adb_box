import 'package:flutter/material.dart';

class ColorConstant {
  ColorConstant._();

  static final Color primary = Color(0xFF2C2C2E);

  static final Color background = Color(0xFF1B1B1C);

  static final Color selected = Color(0xFF679BF9);

  static final Color foreground = Colors.white;

  static final Color cursor = foreground;

  static final Color label = foreground.withOpacity(0.8);

  static final Color hint = foreground.withOpacity(0.6);

  static final Color border = foreground.withOpacity(0.3);
}
