
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IllustrationLine extends StatelessWidget {
  const IllustrationLine({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 7.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EBEF),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
