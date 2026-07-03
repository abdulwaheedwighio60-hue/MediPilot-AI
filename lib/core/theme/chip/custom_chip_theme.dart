import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomChipTheme {
  CustomChipTheme._();

  //==================================
  // LIGHT CHIP THEME
  //==================================

  static ChipThemeData get light => ChipThemeData(
    backgroundColor: AppColors.grey100,
    disabledColor: AppColors.grey200,
    selectedColor: AppColors.primary,

    secondarySelectedColor: AppColors.primary,

    deleteIconColor: AppColors.grey600,

    checkmarkColor: Colors.white,

    selectedShadowColor: Colors.transparent,

    shadowColor: Colors.transparent,

    surfaceTintColor: Colors.transparent,

    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),

    labelStyle: const TextStyle(
      color: AppColors.lightTextPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),

    secondaryLabelStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),

    side: const BorderSide(
      color: AppColors.grey200,
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );

  //==================================
  // DARK CHIP THEME
  //==================================

  static ChipThemeData get dark => ChipThemeData(
    backgroundColor: AppColors.grey800,
    disabledColor: AppColors.grey700,
    selectedColor: AppColors.primary,

    secondarySelectedColor: AppColors.primary,

    deleteIconColor: AppColors.grey300,

    checkmarkColor: Colors.white,

    selectedShadowColor: Colors.transparent,

    shadowColor: Colors.transparent,

    surfaceTintColor: Colors.transparent,

    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),

    labelStyle: const TextStyle(
      color: AppColors.darkTextPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),

    secondaryLabelStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),

    side: const BorderSide(
      color: AppColors.grey700,
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );
}