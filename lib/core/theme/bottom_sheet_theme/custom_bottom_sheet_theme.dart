import 'package:flutter/material.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';


class CustomBottomSheetTheme {
  CustomBottomSheetTheme._();

  //==========================
  // LIGHT BOTTOM SHEET
  //==========================

  static BottomSheetThemeData get light => BottomSheetThemeData(
    backgroundColor: AppColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: AppColors.lightSurface,

    elevation: 8,

    shadowColor: Colors.black12,

    showDragHandle: true,

    dragHandleColor: AppColors.grey300,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28),
      ),
    ),

    clipBehavior: Clip.antiAlias,
  );

  //==========================
  // DARK BOTTOM SHEET
  //==========================

  static BottomSheetThemeData get dark => BottomSheetThemeData(
    backgroundColor: AppColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: AppColors.darkSurface,

    elevation: 8,

    shadowColor: Colors.black54,

    showDragHandle: true,

    dragHandleColor: AppColors.grey600,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28),
      ),
    ),

    clipBehavior: Clip.antiAlias,
  );
}