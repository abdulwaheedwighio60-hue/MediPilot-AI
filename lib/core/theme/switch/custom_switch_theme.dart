import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomSwitchTheme {
  CustomSwitchTheme._();

  //==================================
  // LIGHT SWITCH THEME
  //==================================

  static SwitchThemeData get light => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),

    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.grey300;
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.grey400;
    }),

    overlayColor: WidgetStateProperty.all(
      AppColors.primary.withOpacity(.10),
    ),

    splashRadius: 22,
  );

  //==================================
  // DARK SWITCH THEME
  //==================================

  static SwitchThemeData get dark => SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),

    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.grey700;
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.grey600;
    }),

    overlayColor: WidgetStateProperty.all(
      AppColors.primary.withOpacity(.15),
    ),

    splashRadius: 22,
  );
}