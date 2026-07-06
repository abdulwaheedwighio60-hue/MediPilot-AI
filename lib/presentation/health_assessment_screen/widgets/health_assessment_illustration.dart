import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/presentation/health_assessment_screen/widgets/illustration_line.dart';

class HealthAssessmentIllustration extends StatelessWidget {
  const HealthAssessmentIllustration();

  static const Color _primaryColor = Color(0xFF19BFAF);
  static const Color _lineColor = Color(0xFFE8EBEF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.w,
      height: 270.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: const Color(0xFFF0F2F4),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 2.h,
            left: 2.w,
            child: Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _primaryColor.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.health_and_safety_outlined,
                size: 22.sp,
                color: _primaryColor,
              ),
            ),
          ),

          Positioned(
            top: 83.h,
            left: 6.w,
            child: IllustrationLine(width: 76.w),
          ),

          Positioned(
            top: 83.h,
            right: 2.w,
            child: IllustrationLine(width: 40.w),
          ),

          Positioned(
            top: 101.h,
            left: 6.w,
            child: IllustrationLine(width: 114.w),
          ),

          Positioned(
            top: 122.h,
            left: 6.w,
            child: Container(
              width: 126.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFF1F3F5),
                ),
              ),
            ),
          ),

          Positioned(
            top: 120.h,
            right: 26.w,
            child: Container(
              width: 56.w,
              height: 42.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE9FFF4),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF88E6A9),
                  width: 1.5,
                ),
              ),
              child: Container(
                width: 21.w,
                height: 21.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF2CD276),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 13.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            top: 181.h,
            left: 6.w,
            child: IllustrationLine(width: 72.w),
          ),

          Positioned(
            top: 199.h,
            left: 6.w,
            child: IllustrationLine(width: 112.w),
          ),

          Positioned(
            left: 6.w,
            right: 6.w,
            bottom: 5.h,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(
                4,
                    (int index) {
                  final bool selected = index == 1;

                  return Container(
                    width: 36.w,
                    height: 42.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFE9FFF4)
                          : Colors.white,
                      borderRadius:
                      BorderRadius.circular(10.r),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF88E6A9)
                            : const Color(0xFFF1F3F5),
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: selected
                        ? Container(
                      width: 20.w,
                      height: 20.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2CD276),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 12.sp,
                        color: Colors.white,
                      ),
                    )
                        : null,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}