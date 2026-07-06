import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';

class StepHeaderItem extends StatelessWidget {
  const StepHeaderItem({
    super.key,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.primaryColor,
    required this.borderColor,
    required this.textColor,
    required this.inactiveTextColor,
    required this.onTap,
  });

  final String label;
  final int index;
  final int currentIndex;
  final Color primaryColor;
  final Color borderColor;
  final Color textColor;
  final Color inactiveTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final bool completed = index < currentIndex;
    final bool current = index == currentIndex;

    final Color inactiveCircleColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final Color inactiveDotColor = isDark
        ? AppColors.darkBorder
        : AppColors.lightBorder;

    final Color activeBorderColor = current || completed
        ? AppColors.primary
        : borderColor;

    final Color circleFillColor = completed
        ? AppColors.primary
        : inactiveCircleColor;

    // ✅ ADDED: Step label colors according to light/dark mode
    final Color activeStepTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final Color inactiveStepTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final Color splashColor = primaryColor.withValues(
      alpha: isDark ? 0.16 : 0.10,
    );

    final Color highlightColor = primaryColor.withValues(
      alpha: isDark ? 0.10 : 0.06,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 2.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: 23.w,
                height: 23.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: circleFillColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: activeBorderColor,
                    width: current ? 2 : 1.5,
                  ),
                  boxShadow: current
                      ? <BoxShadow>[
                    BoxShadow(
                      color: primaryColor.withValues(
                        alpha: isDark ? 0.24 : 0.14,
                      ),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                      : null,
                ),
                child: completed
                    ? Icon(
                  Icons.check_rounded,
                  size: 14.sp,
                  color: AppColors.white,
                )
                    : AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: current ? 7.w : 5.w,
                  height: current ? 7.w : 5.w,
                  decoration: BoxDecoration(
                    color: current
                        ? AppColors.primary
                        : inactiveDotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  // ✅ CHANGED: Text color now supports light/dark mode
                  color: current || completed
                      ? activeStepTextColor
                      : inactiveStepTextColor,
                  fontSize: 11.sp,
                  fontWeight: current
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}