import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/presentation/dashboard_screens/dashboard_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
    this.userName = 'Abdul',
    this.userPlan = UserPlan.free,
  });

  final String userName;
  final UserPlan userPlan;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedBottomIndex = 0;

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBackground
        : AppColors.lightBackground;
  }

  Color _surfaceColor(BuildContext context) {
    return _isDark(context) ? AppColors.darkCard : AppColors.lightCard;
  }

  Color _primaryTextColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
  }

  Color _secondaryTextColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
  }

  List<Widget> get _pages {
    return <Widget>[
      HomeScreen(
        userName: widget.userName,
        userPlan: widget.userPlan,
      ),
      const _PlaceholderTabScreen(
        title: 'Insights',
        subtitle: 'Your health insights will appear here.',
        icon: Icons.bar_chart_rounded,
      ),
      const _PlaceholderTabScreen(
        title: 'Plans',
        subtitle: 'Your health and subscription plans will appear here.',
        icon: Icons.assignment_outlined,
      ),
      const _PlaceholderTabScreen(
        title: 'Profile',
        subtitle: 'Your profile information will appear here.',
        icon: Icons.person_outline_rounded,
      ),
    ];
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

  void _onBottomItemTap({
    required int index,
    required bool locked,
    required String label,
  }) {
    if (locked) {
      _showLockedFeatureMessage(label);
      return;
    }

    setState(() {
      _selectedBottomIndex = index;
    });
  }

  void _showAddOptionsSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return _buildAddOptionsSheet(sheetContext);
      },
    );
  }

  Widget _buildAddOptionsSheet(BuildContext sheetContext) {
    final List<_AddOption> options = <_AddOption>[
      _AddOption(
        title: 'Water',
        subtitle: 'Log intake',
        icon: Icons.water_drop_rounded,
        iconColor: const Color(0xFF0284C7),
        backgroundColor: const Color(0xFFE0F2FE),
        locked: false,
      ),
      _AddOption(
        title: 'Medication',
        subtitle: 'Add reminder',
        icon: Icons.medication_rounded,
        iconColor: const Color(0xFFD97706),
        backgroundColor: const Color(0xFFFFF3D8),
        locked: false,
      ),
      _AddOption(
        title: 'Reminder',
        subtitle: 'Custom alert',
        icon: Icons.notifications_active_outlined,
        iconColor: AppColors.primary,
        backgroundColor: const Color(0xFFE0FDF8),
        locked: false,
      ),
      _AddOption(
        title: 'Heart Rate',
        subtitle: 'Track bpm',
        icon: Icons.favorite_rounded,
        iconColor: AppColors.error,
        backgroundColor: const Color(0xFFFFE4EA),
        locked: widget.userPlan == UserPlan.free,
      ),
      _AddOption(
        title: 'Oxygen',
        subtitle: 'SpO2 level',
        icon: Icons.bloodtype_rounded,
        iconColor: const Color(0xFF2563EB),
        backgroundColor: const Color(0xFFDBEAFE),
        locked: widget.userPlan == UserPlan.free,
      ),
      _AddOption(
        title: 'Weight',
        subtitle: 'Body weight',
        icon: Icons.monitor_weight_outlined,
        iconColor: const Color(0xFF7C3AED),
        backgroundColor: const Color(0xFFF3E8FF),
        locked: widget.userPlan == UserPlan.free,
      ),
      _AddOption(
        title: 'Activity',
        subtitle: 'Workout log',
        icon: Icons.directions_walk_rounded,
        iconColor: const Color(0xFF16A34A),
        backgroundColor: const Color(0xFFDCFCE7),
        locked: widget.userPlan == UserPlan.free,
      ),
      _AddOption(
        title: 'Sleep',
        subtitle: 'Sleep hours',
        icon: Icons.bedtime_rounded,
        iconColor: const Color(0xFF4F46E5),
        backgroundColor: const Color(0xFFE0E7FF),
        locked: widget.userPlan != UserPlan.premium,
      ),
      _AddOption(
        title: 'Meal',
        subtitle: 'Food intake',
        icon: Icons.restaurant_rounded,
        iconColor: const Color(0xFFEA580C),
        backgroundColor: const Color(0xFFFFEDD5),
        locked: widget.userPlan != UserPlan.premium,
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        24.h + MediaQuery.paddingOf(sheetContext).bottom,
      ),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _isDark(context)
                ? Colors.black.withOpacity(0.35)
                : Colors.black.withOpacity(0.16),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 42.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: _isDark(context)
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),

          SizedBox(height: 22.h),

          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Add Health Data',
                      style: TextStyle(
                        color: _primaryTextColor(context),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Choose what you want to track today.',
                      style: TextStyle(
                        color: _secondaryTextColor(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.pop(sheetContext);
                },
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: _isDark(context)
                        ? AppColors.darkSurface
                        : AppColors.grey100,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: _secondaryTextColor(context),
                    size: 22.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          GridView.builder(
            itemCount: options.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (BuildContext context, int index) {
              final _AddOption option = options[index];

              return _buildAddOptionCard(
                option: option,
                sheetContext: sheetContext,
              );
            },
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.lock_outline_rounded,
                size: 14.sp,
                color: _secondaryTextColor(context),
              ),
              SizedBox(width: 6.w),
              Text(
                'Some features are available in Basic or Premium plans',
                style: TextStyle(
                  color: _secondaryTextColor(context),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddOptionCard({
    required _AddOption option,
    required BuildContext sheetContext,
  }) {
    return InkWell(
      onTap: () {
        if (option.locked) {
          Navigator.pop(sheetContext);
          _showLockedFeatureMessage(option.title);
          return;
        }

        Navigator.pop(sheetContext);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: _surfaceColor(context),
              content: Text(
                '${option.title} selected.',
                style: TextStyle(
                  color: _primaryTextColor(context),
                ),
              ),
            ),
          );
      },
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: _isDark(context) ? AppColors.darkSurface : AppColors.grey50,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: option.locked
                ? (_isDark(context)
                ? AppColors.darkBorder
                : AppColors.lightBorder)
                : AppColors.primary.withOpacity(0.20),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: option.locked ? 0.52 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: option.locked
                          ? _secondaryTextColor(context).withOpacity(0.12)
                          : option.backgroundColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      option.icon,
                      color: option.locked
                          ? _secondaryTextColor(context)
                          : option.iconColor,
                      size: 25.sp,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    option.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _primaryTextColor(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Text(
                    option.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _secondaryTextColor(context),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            if (option.locked)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    color: _surfaceColor(context),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isDark(context)
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                    ),
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: _secondaryTextColor(context),
                    size: 12.sp,
                  ),
                ),
              ),
          ],
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
          IndexedStack(
            index: _selectedBottomIndex,
            children: _pages,
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 94.h,
      padding: EdgeInsets.fromLTRB(
        18.w,
        9.h,
        18.w,
        7.h,
      ),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _isDark(context)
                ? Colors.black.withOpacity(0.35)
                : Colors.black.withOpacity(0.10),
            blurRadius: 26,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildBottomItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Home',
            ),
            _buildBottomItem(
              index: 1,
              icon: Icons.bar_chart_rounded,
              label: 'Insights',
              locked: widget.userPlan == UserPlan.free,
            ),
            _buildAddButton(),
            _buildBottomItem(
              index: 2,
              icon: Icons.assignment_outlined,
              label: 'Plans',
            ),
            _buildBottomItem(
              index: 3,
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              showDot: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomItem({
    required int index,
    required IconData icon,
    required String label,
    bool locked = false,
    bool showDot = false,
  }) {
    final bool selected = _selectedBottomIndex == index;

    return InkWell(
      onTap: () {
        _onBottomItemTap(
          index: index,
          locked: locked,
          label: label,
        );
      },
      borderRadius: BorderRadius.circular(18.r),
      child: SizedBox(
        width: 58.w,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  locked ? Icons.lock_outline_rounded : icon,
                  color:
                  selected ? AppColors.primary : _secondaryTextColor(context),
                  size: 26.sp,
                ),
                SizedBox(height: 5.h),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? AppColors.primary
                        : _secondaryTextColor(context),
                    fontSize: 12.sp,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),

            if (showDot)
              Positioned(
                top: 0,
                right: 12.w,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: _showAddOptionsSheet,
      customBorder: const CircleBorder(),
      child: Transform.translate(
        offset: Offset(0, -22.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  colors: <Color>[
                    AppColors.primaryLight,
                    AppColors.primaryDark
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.32),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.white,
                size: 39.sp,
              ),
            ),
            // SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

class _AddOption {
  const _AddOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.locked,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final bool locked;
}

class _PlaceholderTabScreen extends StatelessWidget {
  const _PlaceholderTabScreen({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor =
    isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final Color surfaceColor =
    isDark ? AppColors.darkCard : AppColors.lightCard;

    final Color primaryTextColor =
    isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final Color secondaryTextColor =
    isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  title,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 13.sp,
                    height: 1.5,
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