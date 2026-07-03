import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScreenUtil {
  static Widget init({
    required Widget child,
    required Widget Function(BuildContext, Widget?) builder,
  }) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: builder,
      child: child,
    );
  }
}