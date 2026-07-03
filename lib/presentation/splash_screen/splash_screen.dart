import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2),(){
      if(!mounted) return;
      context.go(AppRoutes.welcomeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlay.style(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),

                  /// App Logo
                  Image.asset(
                    AppImages.appLogo,
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 24.h),

                  /// App Name
                  Text(
                    "MedPilot AI",
                    style: textTheme.headlineSmall?.copyWith(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Tagline
                  Text(
                    "AI-Powered Healthcare Assistant",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 15.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const Spacer(),

                  /// Progress Indicator
                  SizedBox(
                    width: 160.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: LinearProgressIndicator(
                        minHeight: 4.h,
                        backgroundColor: Colors.grey.shade300,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// Loading Text
                  Text(
                    "Loading...",
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                      letterSpacing: 1.w,
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}