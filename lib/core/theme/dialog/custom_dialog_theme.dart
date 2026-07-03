import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class CustomDialogTheme {
  CustomDialogTheme._();

  //=========================
  // LIGHT
  //=========================

  static DialogThemeData get light => DialogThemeData(
    backgroundColor: AppColors.lightSurface,

    surfaceTintColor: Colors.transparent,

    elevation: 0,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),

    titleTextStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
    ),

    contentTextStyle: const TextStyle(
      fontSize: 15,
      height: 1.5,
      color: AppColors.lightTextSecondary,
    ),
  );

  //=========================
  // DARK
  //=========================

  static DialogThemeData get dark => DialogThemeData(
    backgroundColor: AppColors.darkSurface,

    surfaceTintColor: Colors.transparent,

    elevation: 0,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),

    titleTextStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
    ),

    contentTextStyle: const TextStyle(
      fontSize: 15,
      height: 1.5,
      color: AppColors.darkTextSecondary,
    ),
  );
}