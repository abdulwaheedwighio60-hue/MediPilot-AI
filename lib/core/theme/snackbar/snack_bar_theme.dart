import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomSnackBarTheme {
  CustomSnackBarTheme._();

  //==========================
  // LIGHT
  //==========================

  static SnackBarThemeData get light => SnackBarThemeData(
    backgroundColor: AppColors.grey900,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    actionTextColor: AppColors.primary,
    disabledActionTextColor: Colors.white54,
    elevation: 6,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  //==========================
  // DARK
  //==========================

  static SnackBarThemeData get dark => SnackBarThemeData(
    backgroundColor: AppColors.grey800,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    actionTextColor: AppColors.primary,
    disabledActionTextColor: Colors.white54,
    elevation: 6,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}