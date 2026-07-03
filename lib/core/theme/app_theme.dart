import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/theme/app_bar_theme/custom_app_bar_theme.dart';
import 'package:med_pilot_ai/core/theme/bottom_sheet_theme/custom_bottom_sheet_theme.dart';
import 'package:med_pilot_ai/core/theme/card/custom_card_theme.dart';
import 'package:med_pilot_ai/core/theme/check_box/check_box_theme.dart';
import 'package:med_pilot_ai/core/theme/chip/custom_chip_theme.dart';
import 'package:med_pilot_ai/core/theme/dialog/custom_dialog_theme.dart';
import 'package:med_pilot_ai/core/theme/input/custom_input_decoration_theme.dart';
import 'package:med_pilot_ai/core/theme/snackbar/snack_bar_theme.dart';
import 'package:med_pilot_ai/core/theme/switch/custom_switch_theme.dart';
import 'package:med_pilot_ai/core/theme/text/text_theme.dart';


class AppTheme {
  AppTheme._();

  //====================================
  // LIGHT THEME
  //====================================

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorSchemeSeed: AppColors.primary,

    scaffoldBackgroundColor: AppColors.lightBackground,

    canvasColor: AppColors.lightBackground,

    textTheme: AppTextTheme.lightTextTheme,

    appBarTheme: CustomAppBarTheme.light,

    bottomSheetTheme: CustomBottomSheetTheme.light,

    // elevatedButtonTheme: CustomElevatedButtonTheme.light,
    //
    // outlinedButtonTheme: CustomOutlinedButtonTheme.light,

    inputDecorationTheme: CustomInputDecorationTheme.light,

    cardTheme: CustomCardTheme.light,

    dialogTheme: CustomDialogTheme.light,

    snackBarTheme: CustomSnackBarTheme.light,

    checkboxTheme: CustomCheckboxTheme.light,

    //radioTheme: CustomRadioTheme.light,

    switchTheme: CustomSwitchTheme.light,

    chipTheme: CustomChipTheme.light,

    // bottomNavigationBarTheme:
    // CustomBottomSheetTheme.light,
    //
    // navigationBarTheme:
    // CustomNavigationBarTheme.light,
  );

  //====================================
  // DARK THEME
  //====================================

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorSchemeSeed: AppColors.primary,

    scaffoldBackgroundColor: AppColors.darkBackground,

    canvasColor: AppColors.darkBackground,

    textTheme: AppTextTheme.darkTextTheme,

    appBarTheme: CustomAppBarTheme.dark,

    bottomSheetTheme: CustomBottomSheetTheme.dark,

    // elevatedButtonTheme: CustomElevatedButtonTheme.dark,
    //
    // outlinedButtonTheme: CustomOutlinedButtonTheme.dark,

    inputDecorationTheme: CustomInputDecorationTheme.dark,

    cardTheme: CustomCardTheme.dark,

    dialogTheme: CustomDialogTheme.dark,

    snackBarTheme: CustomSnackBarTheme.dark,

    checkboxTheme: CustomCheckboxTheme.dark,

    // radioTheme: CustomRadioTheme.dark,

    switchTheme: CustomSwitchTheme.dark,

    chipTheme: CustomChipTheme.dark,

    // bottomNavigationBarTheme:
    // CustomBottomNavigationBarTheme.dark,
    //
    // navigationBarTheme:
    // CustomNavigationBarTheme.dark,
  );
}