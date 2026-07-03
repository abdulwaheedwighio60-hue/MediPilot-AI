import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final double? width;
  final double? height;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? shadowColor;
  final Color? borderColor;
  final Color? loadingIndicatorColor;

  final double borderRadius;
  final double borderWidth;
  final double elevation;

  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final double iconSpacing;
  final bool isLoading;
  final bool isExpanded;

  final MainAxisAlignment contentAlignment;
  final AlignmentGeometry alignment;

  final OutlinedBorder? shape;
  final Size? minimumSize;
  final Size? maximumSize;

  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? tapTargetSize;

  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.shadowColor,
    this.borderColor,
    this.loadingIndicatorColor,
    this.borderRadius = 12,
    this.borderWidth = 0,
    this.elevation = 0,
    this.padding,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing = 10,
    this.isLoading = false,
    this.isExpanded = true,
    this.contentAlignment = MainAxisAlignment.center,
    this.alignment = Alignment.center,
    this.shape,
    this.minimumSize,
    this.maximumSize,
    this.visualDensity,
    this.tapTargetSize,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color effectiveBackgroundColor =
        backgroundColor ?? AppColors.primary;

    final Color effectiveForegroundColor =
        foregroundColor ?? AppColors.white;

    final Color effectiveDisabledBackgroundColor =
        disabledBackgroundColor ??
            effectiveBackgroundColor.withOpacity(0.45);

    final Color effectiveDisabledForegroundColor =
        disabledForegroundColor ??
            AppColors.white.withOpacity(0.70);

    final Color effectiveLoadingColor =
        loadingIndicatorColor ?? effectiveForegroundColor;

    final Widget button = SizedBox(
      width: isExpanded ? double.infinity : width,
      height: height?.h ?? 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          disabledBackgroundColor: effectiveDisabledBackgroundColor,
          disabledForegroundColor: effectiveDisabledForegroundColor,
          shadowColor: shadowColor ?? AppColors.transparent,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 12.h,
              ),
          minimumSize: minimumSize,
          maximumSize: maximumSize,
          visualDensity: visualDensity,
          tapTargetSize: tapTargetSize,
          alignment: alignment,
          side: borderWidth > 0
              ? BorderSide(
            color: borderColor ??
                (isDarkMode
                    ? AppColors.darkBorder
                    : AppColors.lightBorder),
            width: borderWidth,
          )
              : BorderSide.none,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
              ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
            key: const ValueKey('loading'),
            width: 21.w,
            height: 21.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveLoadingColor,
              ),
            ),
          )
              : Row(
            key: const ValueKey('content'),
            mainAxisSize:
            isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: contentAlignment,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: iconSpacing.w),
              ],
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: effectiveForegroundColor,
                      ),
                ),
              ),
              if (suffixIcon != null) ...[
                SizedBox(width: iconSpacing.w),
                suffixIcon!,
              ],
            ],
          ),
        ),
      ),
    );

    if (isExpanded) {
      return button;
    }

    return SizedBox(
      width: width,
      child: button,
    );
  }
}