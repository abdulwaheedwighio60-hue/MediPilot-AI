import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'package:med_pilot_ai/core/constants/app_colors.dart';

enum UserPlan {
  free,
  basic,
  premium,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.userName = 'Abdul',
    this.userPlan = UserPlan.free,
  });

  final String userName;
  final UserPlan userPlan;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomIndex = 0;
  bool _showDailyTip = true;

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBackground
        : const Color(0xFFF8FAFC);
  }

  Color _surfaceColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkCard
        : AppColors.white;
  }

  Color _primaryTextColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextPrimary
        : const Color(0xFF111827);
  }

  Color _secondaryTextColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextSecondary
        : const Color(0xFF64748B);
  }

  Color _borderColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBorder
        : const Color(0xFFE5E7EB);
  }

  Color _softCardShadow(BuildContext context) {
    return _isDark(context)
        ? Colors.black.withOpacity(0.30)
        : Colors.black.withOpacity(0.08);
  }

  String get _planName {
    switch (widget.userPlan) {
      case UserPlan.free:
        return 'Free';
      case UserPlan.basic:
        return 'Basic';
      case UserPlan.premium:
        return 'Premium';
    }
  }

  String get _healthScore {
    switch (widget.userPlan) {
      case UserPlan.free:
        return '72/100';
      case UserPlan.basic:
        return '84/100';
      case UserPlan.premium:
        return '92/100';
    }
  }

  void _showLockedFeatureMessage(String featureName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _surfaceColor(context),
          content: Text(
            '$featureName is available in higher plans.',
            style: TextStyle(
              color: _primaryTextColor(context),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(context),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: _showDailyTip ? 245.h : 118.h,
            ),
            child: Column(
              children: <Widget>[
                _buildTopHeader(),
                _buildMainContent(),
              ],
            ),
          ),

          if (_showDailyTip)
            Positioned(
              left: 18.w,
              right: 18.w,
              bottom: 92.h,
              child: _buildDailyTipCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      height: 305.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isDark(context)
              ? const <Color>[
            Color(0xFF0F766E),
            Color(0xFF134E4A),
            Color(0xFF0F172A),
          ]
              : const <Color>[
            AppColors.primary,
            AppColors.primary,
            AppColors.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24.w,
            18.h,
            24.w,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 10.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hello, ${widget.userName} 👋',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.10,
                          ),
                        ),

                        // SizedBox(height: 5.h),

                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.92),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 11.w,
                        //     vertical: 5.h,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: AppColors.white.withOpacity(0.18),
                        //     borderRadius: BorderRadius.circular(30.r),
                        //     border: Border.all(
                        //       color: AppColors.white.withOpacity(0.26),
                        //     ),
                        //   ),
                        //   child: Text(
                        //     '$_planName Plan',
                        //     style: TextStyle(
                        //       color: AppColors.white,
                        //       fontSize: 11.sp,
                        //       fontWeight: FontWeight.w800,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  _buildNotificationButton(),

                  SizedBox(width: 14.w),

                  _buildProfileAvatar(
                    imageUrl: ""
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: 58.w,
          height: 58.w,
          // decoration: BoxDecoration(
          //   color: AppColors.white,
          //   borderRadius: BorderRadius.circular(18.r),
          //   boxShadow: <BoxShadow>[
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.08),
          //       blurRadius: 16,
          //       offset: const Offset(0, 8),
          //     ),
          //   ],
          // ),
          child: Icon(
            CupertinoIcons.bell_fill,
            size: 40.sp,
            color: AppColors.lightCard,
          ),
        ),

        Positioned(
          top: 10.h,
          right: 12.w,
          child: Container(
            width: 10.w,
            height: 10.w,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar({String? imageUrl}) {
    return Container(
      width: 58.w,
      height: 58.w,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withOpacity(0.45),
        border: Border.all(
          color: AppColors.white.withOpacity(0.82),
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl.trim().isNotEmpty
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.grey200,
              child: Icon(
                Icons.person_rounded,
                color: AppColors.grey600,
                size: 35.sp,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Container(
              color: AppColors.grey200,
              alignment: Alignment.center,
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        )
            : Container(
          color: AppColors.grey200,
          child: Icon(
            Icons.person_rounded,
            color: AppColors.grey600,
            size: 35.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Transform.translate(
      offset: Offset(0, -58.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHealthScoreCard(),

            SizedBox(height: 32.h),

            _buildSectionTitle(
              title: 'Health Metrics',
              onViewAll: () {},
            ),

            SizedBox(height: 16.h),

            Row(
              children: <Widget>[
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.favorite_rounded,
                    iconColor: AppColors.error,
                    iconBackground: const Color(0xFFFFE4EA),
                    value: '72',
                    unit: 'bpm',
                    title: 'Heart Rate',
                    chartColor: const Color(0xFFF59E0B),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.water_drop_rounded,
                    iconColor: const Color(0xFFF59E0B),
                    iconBackground: const Color(0xFFFFF3D8),
                    value: '98%',
                    unit: '',
                    title: 'Oxygen Saturation',
                    chartColor: const Color(0xFF2487FF),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            _buildSectionTitle(
              title: 'Upcoming Reminders',
              onViewAll: () {},
            ),

            SizedBox(height: 16.h),

            _buildReminderCard(),

            SizedBox(height: 20.h),

            if (widget.userPlan == UserPlan.free) _buildUpgradeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthScoreCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20.w,
        15.h,
        10.w,
        10.h,
      ),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: _borderColor(context),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _softCardShadow(context),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(21.r),
            ),
            child: Icon(
              Icons.assignment_rounded,
              color: AppColors.primary,
              size: 38.sp,
            ),
          ),

          SizedBox(width: 20.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Health Score',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _primaryTextColor(context),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.info_outline_rounded,
                      color: _secondaryTextColor(context),
                      size: 22.sp,
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.w,
                  runSpacing: 8.h,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_rounded,
                          color: AppColors.error,
                          size: 22.sp,
                        ),
                        SizedBox(width: 7.w),
                        Text(
                          _healthScore,
                          style: TextStyle(
                            color: _primaryTextColor(context),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: 1.w,
                      height: 22.h,
                      color: _borderColor(context),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_upward_rounded,
                          color: AppColors.success,
                          size: 26.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '5% from last week',
                          style: TextStyle(
                            color: _secondaryTextColor(context),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: _primaryTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
        ),

        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onViewAll,
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 4.h,
              ),
              child: Text(
                'View all',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String value,
    required String unit,
    required String title,
    required Color chartColor,
  }) {
    return Container(
      height: 218.h,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: _borderColor(context),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _isDark(context)
                ? Colors.black.withOpacity(0.16)
                : Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 55.w,
            height: 55.w,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 29.sp,
            ),
          ),

          const Spacer(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _primaryTextColor(context),
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
              ),

              if (unit.isNotEmpty) ...<Widget>[
                SizedBox(width: 5.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(
                    unit,
                    style: TextStyle(
                      color: _secondaryTextColor(context),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 7.h),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _primaryTextColor(context),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            children: <Widget>[
              Expanded(
                child: CustomPaint(
                  size: Size(double.infinity, 26.h),
                  painter: MiniWavePainter(
                    color: chartColor,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Normal',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: _borderColor(context),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _isDark(context)
                ? Colors.black.withOpacity(0.14)
                : Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: const Color(0xFFD97706).withOpacity(0.12),
              borderRadius: BorderRadius.circular(17.r),
            ),
            child: Icon(
              Icons.medication_rounded,
              color: const Color(0xFFD97706),
              size: 31.sp,
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Take Medication',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _primaryTextColor(context),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  'Today, 10:00 AM',
                  style: TextStyle(
                    color: _secondaryTextColor(context),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.chevron_right_rounded,
            color: _secondaryTextColor(context),
            size: 30.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeCard() {
    return InkWell(
      onTap: () {
        _showLockedFeatureMessage('Advanced health insights');
      },
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(
            _isDark(context) ? 0.16 : 0.10,
          ),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.25),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.lock_outline_rounded,
              color: AppColors.primary,
              size: 26.sp,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Text(
                'Upgrade your plan to unlock advanced AI insights.',
                style: TextStyle(
                  color: _primaryTextColor(context),
                  fontSize: 13.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTipCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20.w,
          20.h,
          20.w,
          18.h,
        ),
        decoration: BoxDecoration(
          color: _surfaceColor(context),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(
            color: _borderColor(context),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _isDark(context)
                  ? Colors.black.withOpacity(0.32)
                  : Colors.black.withOpacity(0.15),
              blurRadius: 32,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '👋 Daily Tip',
              style: TextStyle(
                color: _primaryTextColor(context),
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.3,
              ),
            ),

            SizedBox(height: 14.h),

            Text(
              'Drink at least 8 glasses of water\nto stay hydrated! 💧',
              style: TextStyle(
                color: _primaryTextColor(context),
                fontSize: 19.sp,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 18.h),

            Divider(
              color: _borderColor(context),
              height: 1,
            ),

            SizedBox(height: 14.h),

            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _showDailyTip = false;
                      });
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        'Don’t show again',
                        style: TextStyle(
                          color: _secondaryTextColor(context),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _showDailyTip = false;
                    });
                  },
                  child: Text(
                    'Not now',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showDailyTip = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                  ),
                  child: Text(
                    'Got it',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 92.h,
//       padding: EdgeInsets.fromLTRB(
//         18.w,
//         9.h,
//         18.w,
//         7.h,
//       ),
//       decoration: BoxDecoration(
//         color: _surfaceColor(context),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24.r),
//           topRight: Radius.circular(24.r),
//         ),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: _isDark(context)
//                 ? Colors.black.withOpacity(0.35)
//                 : Colors.black.withOpacity(0.10),
//             blurRadius: 26,
//             offset: const Offset(0, -10),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             _buildBottomItem(
//               index: 0,
//               icon: Icons.home_rounded,
//               label: 'Home',
//             ),
//             _buildBottomItem(
//               index: 1,
//               icon: Icons.bar_chart_rounded,
//               label: 'Insights',
//               locked: widget.userPlan == UserPlan.free,
//             ),
//             _buildAddButton(),
//             _buildBottomItem(
//               index: 2,
//               icon: Icons.assignment_outlined,
//               label: 'Plans',
//             ),
//             _buildBottomItem(
//               index: 3,
//               icon: Icons.person_outline_rounded,
//               label: 'Profile',
//               showDot: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomItem({
//     required int index,
//     required IconData icon,
//     required String label,
//     bool locked = false,
//     bool showDot = false,
//   }) {
//     final bool selected = _selectedBottomIndex == index;
//
//     return InkWell(
//       onTap: () {
//         if (locked) {
//           _showLockedFeatureMessage(label);
//           return;
//         }
//
//         setState(() {
//           _selectedBottomIndex = index;
//         });
//       },
//       borderRadius: BorderRadius.circular(18.r),
//       child: SizedBox(
//         width: 58.w,
//         child: Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.topCenter,
//           children: <Widget>[
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Icon(
//                   locked ? Icons.lock_outline_rounded : icon,
//                   color: selected
//                       ? AppColors.primary
//                       : _secondaryTextColor(context),
//                   size: 26.sp,
//                 ),
//
//                 SizedBox(height: 5.h),
//
//                 Text(
//                   label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: selected
//                         ? AppColors.primary
//                         : _secondaryTextColor(context),
//                     fontSize: 12.sp,
//                     fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//
//             if (showDot)
//               Positioned(
//                 top: 0,
//                 right: 12.w,
//                 child: Container(
//                   width: 8.w,
//                   height: 8.w,
//                   decoration: const BoxDecoration(
//                     color: AppColors.error,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAddButton() {
//     return InkWell(
//       onTap: () {},
//       customBorder: const CircleBorder(),
//       child: Transform.translate(
//         offset: Offset(0, -16.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//               width: 66.w,
//               height: 66.w,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: <Color>[
//                     Color(0xFF00BFA6),
//                     Color(0xFF0F766E),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: AppColors.primary.withOpacity(0.32),
//                     blurRadius: 22,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.add_rounded,
//                 color: AppColors.white,
//                 size: 39.sp,
//               ),
//             ),
//
//             SizedBox(height: 3.h),
//
//             Text(
//               'Add',
//               style: TextStyle(
//                 color: _secondaryTextColor(context),
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}

class MiniWavePainter extends CustomPainter {
  MiniWavePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path();

    path.moveTo(0, size.height * 0.58);

    path.cubicTo(
      size.width * 0.15,
      size.height * 0.58,
      size.width * 0.18,
      size.height * 0.35,
      size.width * 0.30,
      size.height * 0.35,
    );

    path.cubicTo(
      size.width * 0.43,
      size.height * 0.35,
      size.width * 0.42,
      size.height * 0.80,
      size.width * 0.58,
      size.height * 0.78,
    );

    path.cubicTo(
      size.width * 0.72,
      size.height * 0.76,
      size.width * 0.66,
      size.height * 0.48,
      size.width * 0.82,
      size.height * 0.50,
    );

    path.cubicTo(
      size.width * 0.94,
      size.height * 0.52,
      size.width,
      size.height * 0.68,
      size.width,
      size.height * 0.68,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MiniWavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}