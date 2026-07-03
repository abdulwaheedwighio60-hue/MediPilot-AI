import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSystemUiOverlay {
  static SystemUiOverlayStyle style(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
      isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness:
      isDarkMode ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
      isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness:
      isDarkMode ? Brightness.light : Brightness.dark,
    );
  }
}