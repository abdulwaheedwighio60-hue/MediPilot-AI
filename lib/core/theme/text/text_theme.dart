import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  //==============================
  // LIGHT TEXT THEME
  //==============================

  static TextTheme get lightTextTheme => TextTheme(
    // Display
    displayLarge: _style(
      size: 57,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
      height: 1.12,
    ),
    displayMedium: _style(
      size: 45,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
      height: 1.16,
    ),
    displaySmall: _style(
      size: 36,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
      height: 1.22,
    ),

    // Headline
    headlineLarge: _style(
      size: 32,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
    ),
    headlineMedium: _style(
      size: 28,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
    ),
    headlineSmall: _style(
      size: 24,
      weight: FontWeight.w600,
      color: AppColors.lightTextPrimary,
    ),

    // Title
    titleLarge: _style(
      size: 22,
      weight: FontWeight.w700,
      color: AppColors.lightTextPrimary,
    ),
    titleMedium: _style(
      size: 18,
      weight: FontWeight.w600,
      color: AppColors.lightTextPrimary,
    ),
    titleSmall: _style(
      size: 16,
      weight: FontWeight.w600,
      color: AppColors.lightTextPrimary,
    ),

    // Body
    bodyLarge: _style(
      size: 16,
      weight: FontWeight.w400,
      color: AppColors.lightTextPrimary,
      height: 1.5,
    ),
    bodyMedium: _style(
      size: 14,
      weight: FontWeight.w400,
      color: AppColors.lightTextSecondary,
      height: 1.45,
    ),
    bodySmall: _style(
      size: 12,
      weight: FontWeight.w400,
      color: AppColors.lightHint,
      height: 1.4,
    ),

    // Label
    labelLarge: _style(
      size: 14,
      weight: FontWeight.w600,
      color: AppColors.lightTextPrimary,
    ),
    labelMedium: _style(
      size: 12,
      weight: FontWeight.w500,
      color: AppColors.lightTextSecondary,
    ),
    labelSmall: _style(
      size: 11,
      weight: FontWeight.w500,
      color: AppColors.lightHint,
    ),
  );

  //==============================
  // DARK TEXT THEME
  //==============================

  static TextTheme get darkTextTheme => TextTheme(
    // Display
    displayLarge: _style(
      size: 57,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      height: 1.12,
    ),
    displayMedium: _style(
      size: 45,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      height: 1.16,
    ),
    displaySmall: _style(
      size: 36,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
      height: 1.22,
    ),

    // Headline
    headlineLarge: _style(
      size: 32,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
    ),
    headlineMedium: _style(
      size: 28,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
    ),
    headlineSmall: _style(
      size: 24,
      weight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),

    // Title
    titleLarge: _style(
      size: 22,
      weight: FontWeight.w700,
      color: AppColors.darkTextPrimary,
    ),
    titleMedium: _style(
      size: 18,
      weight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    titleSmall: _style(
      size: 16,
      weight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),

    // Body
    bodyLarge: _style(
      size: 16,
      weight: FontWeight.w400,
      color: AppColors.darkTextPrimary,
      height: 1.5,
    ),
    bodyMedium: _style(
      size: 14,
      weight: FontWeight.w400,
      color: AppColors.darkTextSecondary,
      height: 1.45,
    ),
    bodySmall: _style(
      size: 12,
      weight: FontWeight.w400,
      color: AppColors.darkHint,
      height: 1.4,
    ),

    // Label
    labelLarge: _style(
      size: 14,
      weight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    labelMedium: _style(
      size: 12,
      weight: FontWeight.w500,
      color: AppColors.darkTextSecondary,
    ),
    labelSmall: _style(
      size: 11,
      weight: FontWeight.w500,
      color: AppColors.darkHint,
    ),
  );

  //==============================
  // COMMON STYLE
  //==============================

  static TextStyle _style({
    required double size,
    required FontWeight weight,
    required Color color,
    double height = 1.3,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}