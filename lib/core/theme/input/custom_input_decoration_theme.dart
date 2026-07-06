import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomInputDecorationTheme {
  CustomInputDecorationTheme._();

  //========================
  // LIGHT
  //========================

  static InputDecorationTheme get light => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,

    contentPadding:  EdgeInsets.symmetric(
      horizontal: 13.w,
      vertical: 15.h,
    ),

    hintStyle: const TextStyle(
      color: AppColors.lightHint,
      fontSize: 14,
    ),

    labelStyle: const TextStyle(
      color: AppColors.lightTextSecondary,
      fontWeight: FontWeight.w500,
    ),

    floatingLabelStyle: const TextStyle(
      color: AppColors.primary,
    ),

    prefixIconColor: AppColors.grey500,
    suffixIconColor: AppColors.grey500,

    border: _border(AppColors.lightBorder),

    enabledBorder: _border(AppColors.lightBorder),

    focusedBorder: _border(
      AppColors.primary,
      width: 1.8,
    ),

    disabledBorder: _border(AppColors.grey200),

    errorBorder: _border(
      AppColors.error,
      width: 1.5,
    ),

    focusedErrorBorder: _border(
      AppColors.error,
      width: 2,
    ),
  );

  //========================
  // DARK
  //========================

  static InputDecorationTheme get dark => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,

    contentPadding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 18,
    ),

    hintStyle: const TextStyle(
      color: AppColors.darkHint,
      fontSize: 14,
    ),

    labelStyle: const TextStyle(
      color: AppColors.darkTextSecondary,
      fontWeight: FontWeight.w500,
    ),

    floatingLabelStyle: const TextStyle(
      color: AppColors.primary,
    ),

    prefixIconColor: AppColors.grey400,
    suffixIconColor: AppColors.grey400,

    border: _border(AppColors.darkBorder),

    enabledBorder: _border(AppColors.darkBorder),

    focusedBorder: _border(
      AppColors.primary,
      width: 1.8,
    ),

    disabledBorder: _border(AppColors.grey700),

    errorBorder: _border(
      AppColors.error,
      width: 1.5,
    ),

    focusedErrorBorder: _border(
      AppColors.error,
      width: 2,
    ),
  );

  static OutlineInputBorder _border(
      Color color, {
        double width = 1,
      }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}