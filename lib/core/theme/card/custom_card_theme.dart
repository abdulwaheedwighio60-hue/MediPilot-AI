import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomCardTheme {
  CustomCardTheme._();

  static CardThemeData get light => CardThemeData(
    color: AppColors.lightCard,

    elevation: 0,

    shadowColor: Colors.black12,

    margin: const EdgeInsets.all(8),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(
        color: AppColors.grey100,
      ),
    ),
  );

  static CardThemeData get dark => CardThemeData(
    color: AppColors.darkCard,

    elevation: 0,

    shadowColor: Colors.black54,

    margin: const EdgeInsets.all(8),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(
        color: AppColors.grey700,
      ),
    ),
  );
}