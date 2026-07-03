import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // =========================
  // BRAND COLORS
  // =========================
  static const Color primary = Color(0xFF14B8A6); // Main Brand
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryLight = Color(0xFF5EEAD4);
  static const Color darkBackgroundColor = Color(0xFF111827);
  static const Color brandColor = Color(0xFF042F2E);
  static const Color secondaryDarkBgColor = Color(0xFF030712);
  // =========================
  // LIGHT THEME
  // =========================

  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);

  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightHint = Color(0xFF94A3B8);

  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFF1F5F9);

  // =========================
  // DARK THEME
  // =========================

  static const Color darkBackground = Color(0xFF020617);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkHint = Color(0xFF94A3B8);

  static const Color darkBorder = Color(0xFF334155);
  static const Color darkDivider = Color(0xFF1E293B);

  // =========================
  // STATUS COLORS
  // =========================

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFF43F5E);
  static const Color info = Color(0xFF3B82F6);
  static const Color containerColor = Color(0xFFFDE68A);

  // =========================
  // EXTRA COLORS
  // =========================

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color transparent = Colors.transparent;

  // Shadow
  static const Color shadow = Color(0x1A000000);

  // Disabled
  static const Color disabled = Color(0xFF94A3B8);

  // Icon Colors
  static const Color iconLight = Color(0xFF334155);
  static const Color iconDark = Color(0xFFE2E8F0);

  // Grey Shades
  static const Color grey50 = Color(0xFFF8FAFC);
  static const Color grey100 = Color(0xFFF1F5F9);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E1);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey600 = Color(0xFF475569);
  static const Color grey700 = Color(0xFF334155);
  static const Color grey800 = Color(0xFF1E293B);
  static const Color grey900 = Color(0xFF0F172A);

// =========================
// WELCOME SCREEN COLORS
// =========================

// Light Mode
  static const Color welcomeLightBackground = Color(0xFFF9FAFB);
  static const Color welcomeLightHeading = Color(0xFF1F2937);
  static const Color welcomeLightDescription = Color(0xFF667085);
  static const Color welcomeLightSecondaryText = Color(0xFF7A7F87);

// Dark Mode
// Existing colors reuse honge:
// darkSurface
// darkTextPrimary
// darkTextSecondary
// darkHint
// primaryLight

  static const LinearGradient welcomeLightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.00,
      0.35,
      0.60,
      0.78,
      1.00,
    ],
    colors: [
      Color(0xFF82D8CF),
      Color(0xFFA5E1DB),
      Color(0xFFDDF2F0),
      Color(0xFFF7FAFA),
      Color(0xFFF9FAFB),
    ],
  );

  static const LinearGradient welcomeDarkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.00,
      0.35,
      0.60,
      0.78,
      1.00,
    ],
    colors: [
      Color(0xFF164E4A),
      Color(0xFF134E4A),
      Color(0xFF172F3D),
      Color(0xFF111D2D),
      Color(0xFF0F172A),
    ],
  );



  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF14B8A6),
      Color(0xFF0F766E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF2563EB),
    ],
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [
      Color(0xFF22C55E),
      Color(0xFF15803D),
    ],
  );

  static const Color glassLight = Color(0x99FFFFFF);
  static const Color glassDark = Color(0x1FFFFFFF);

  static const Color blurBorderLight = Color(0x33FFFFFF);
  static const Color blurBorderDark = Color(0x22FFFFFF);


  static const Color shadowLight = Color(0x14000000);
  static const Color shadowDark = Color(0x33000000);










  // =========================
// ONBOARDING SCREEN COLORS
// =========================

  static const LinearGradient onboardingLightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE1F8F4),
      Color(0xFFF1FBF9),
      Color(0xFFF8FAFC),
    ],
  );

  static const LinearGradient onboardingDarkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF103C3A),
      Color(0xFF0F292C),
      Color(0xFF0F172A),
    ],
  );

  static const Color onboardingLightPanel = Color(0xFFFFFFFF);
  static const Color onboardingDarkPanel = Color(0xFF0F172A);

  static const Color onboardingLightNavigationButton = Color(0xFF1F2937);
  static const Color onboardingDarkNavigationButton = Color(0xFF1E293B);
}










