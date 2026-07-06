import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class PlanOptionCard extends StatelessWidget {
  const PlanOptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.selected,
    required this.primaryColor,
    required this.borderColor,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool selected;
  final Color primaryColor;
  final Color borderColor;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color cardColor = isDark
        ? AppColors.darkCard
        : AppColors.lightCard;

    final Color titleColor = isDark
        ? Colors.white
        : AppColors.darkTextPrimary;

    final Color subtitleColor = isDark
        ? Colors.white.withOpacity(0.70)
        : AppColors.darkTextSecondary;

    final Color normalBorderColor = isDark
        ? Colors.white.withOpacity(0.12)
        : borderColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: EdgeInsets.all(18.r),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: selected ? primaryColor : normalBorderColor,
              width: selected ? 1.7 : 1,
            ),
            boxShadow: selected
                ? <BoxShadow>[
              BoxShadow(
                color: primaryColor.withOpacity(
                  isDark ? 0.22 : 0.10,
                ),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: titleColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  if (badge != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(
                          isDark ? 0.18 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        badge!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),

                  SizedBox(width: 10.w),

                  Container(
                    width: 23.w,
                    height: 23.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? primaryColor : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? primaryColor : normalBorderColor,
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? Icon(
                      Icons.check_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    price,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: titleColor,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(width: 4.w),

                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      period,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                  fontSize: 12.sp,
                  height: 1.45,
                ),
              ),

              SizedBox(height: 16.h),

              ...features.map(
                    (String feature) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(
                              isDark ? 0.18 : 0.12,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 13.sp,
                            color: primaryColor,
                          ),
                        ),

                        SizedBox(width: 10.w),

                        Expanded(
                          child: Text(
                            feature,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: titleColor,
                              fontSize: 12.sp,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}