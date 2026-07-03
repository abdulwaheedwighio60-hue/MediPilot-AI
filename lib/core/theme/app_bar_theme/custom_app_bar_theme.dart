import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  //==========================
  // LIGHT APP BAR
  //==========================

  static AppBarTheme get light => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightTextPrimary,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,

    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
      letterSpacing: .2,
    ),

    iconTheme: const IconThemeData(
      color: AppColors.lightTextPrimary,
      size: 24,
    ),

    actionsIconTheme: const IconThemeData(
      color: AppColors.lightTextPrimary,
      size: 24,
    ),
  );

  //==========================
  // DARK APP BAR
  //==========================

  static AppBarTheme get dark => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkTextPrimary,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,

    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      letterSpacing: .2,
    ),

    iconTheme: const IconThemeData(
      color: AppColors.darkTextPrimary,
      size: 24,
    ),

    actionsIconTheme: const IconThemeData(
      color: AppColors.darkTextPrimary,
      size: 24,
    ),
  );
}