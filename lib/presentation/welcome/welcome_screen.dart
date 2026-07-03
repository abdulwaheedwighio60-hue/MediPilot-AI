import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/core/widgets/app_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    // Light / Dark mode dependent colors
    final scaffoldBackgroundColor = isDarkMode
        ? AppColors.darkSurface
        : AppColors.welcomeLightBackground;

    final headingColor = isDarkMode
        ? AppColors.darkTextPrimary
        : AppColors.welcomeLightHeading;

    final descriptionColor = isDarkMode
        ? AppColors.darkTextSecondary
        : AppColors.welcomeLightDescription;

    final secondaryTextColor = isDarkMode
        ? AppColors.darkHint
        : AppColors.welcomeLightSecondaryText;

    final signInColor = isDarkMode
        ? AppColors.primaryLight
        : AppColors.primary;

    final welcomeGradient = isDarkMode
        ? AppColors.welcomeDarkGradient
        : AppColors.welcomeLightGradient;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlay.style(context),
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: welcomeGradient,
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 45.h),

                          // Welcome illustration
                          Center(
                            child: Image.asset(
                              AppImages.welcomeScreenImage,
                              width: 330.w,
                              height: 330.h,
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: 80.h),

                          // Heading
                          Text(
                            'Welcome to MedPilot\nAI!',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: 30.sp,
                              height: 1.12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: headingColor,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Description
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              'We bring all of your health information\n'
                                  'together in one app, with the power of AI',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16.sp,
                                height: 1.55,
                                fontWeight: FontWeight.w400,
                                color: descriptionColor,
                              ),
                            ),
                          ),

                          SizedBox(height: 35.h),

                          // Get started button
                          SizedBox(
                            width: double.infinity,
                            height: 55.h,
                            child: AppElevatedButton(
                              text: "Let's Get Started",
                              textStyle: TextStyle(
                                fontSize: 13
                              ),
                              onPressed: () {
                                context.go(AppRoutes.onboardingScreen);
                                print("object");
                              },
                              isLoading: false,
                              // height: 50,
                              isExpanded: true,
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              borderRadius: 15,
                              elevation: 0,

                              suffixIcon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 25.h),

                          // Sign-in section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryTextColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   '/sign-in',
                                  // );
                                },
                                child: Text(
                                  'Sign In.',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: signInColor,
                                    color: signInColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}