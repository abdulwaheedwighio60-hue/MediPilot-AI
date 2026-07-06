import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';

class ActionMenuTile extends StatelessWidget {
  const ActionMenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconBorderColor,
    this.trailingIcon = CupertinoIcons.right_chevron,
    this.isLoading = false,
    this.isEnabled = true,
    this.splashColor,
    this.highlightColor,
    this.backgroundColor,
    this.borderColor,

  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? iconBorderColor;

  final IconData trailingIcon;
  final bool isLoading;
  final bool isEnabled;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Color primaryColor = iconColor ?? AppColors.success;

    return Opacity(
      opacity: isEnabled ? 1 : 0.55,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: isEnabled && !isLoading ? onTap : null,
          borderRadius: BorderRadius.circular(12.r),
          splashColor: splashColor ?? primaryColor.withValues(alpha: 0.08),
          highlightColor: highlightColor ?? primaryColor.withValues(alpha: 0.04),
          child: Ink(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: borderColor ?? AppColors.borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.035),
                  blurRadius: 10.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBackgroundColor ??
                        primaryColor.withValues(alpha: 0.12),
                    border: Border.all(
                      color: iconBorderColor ??
                          primaryColor.withValues(alpha: 0.30),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 23.sp,
                    color: primaryColor,
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,

                        ),
                      ),

                      if (subtitle != null &&
                          subtitle!.trim().isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,

                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(width: 10.w),

                if (isLoading)
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primaryColor,
                    ),
                  )
                else
                  Container(
                    width: 30.w,
                    height: 30.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(

                    ),
                    child: Icon(
                      trailingIcon,
                      size: 20.sp,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}