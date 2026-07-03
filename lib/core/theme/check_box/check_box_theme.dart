import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomCheckboxTheme {
  CustomCheckboxTheme._();

  //==========================
  // LIGHT
  //==========================

  static CheckboxThemeData get light => CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),

    side: const BorderSide(
      color: AppColors.grey400,
      width: 1.5,
    ),

    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }

      return Colors.transparent;
    }),

    checkColor: WidgetStateProperty.all(
      Colors.white,
    ),
  );

  //==========================
  // DARK
  //==========================

  static CheckboxThemeData get dark => CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),

    side: const BorderSide(
      color: AppColors.grey500,
      width: 1.5,
    ),

    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }

      return Colors.transparent;
    }),

    checkColor: WidgetStateProperty.all(
      Colors.white,
    ),
  );
}