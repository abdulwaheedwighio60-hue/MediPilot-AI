import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/router/app_router.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      image: AppImages.frameImage1,
      title: 'Personalized Health\nThat You Can Control',
      description:
      'Take charge of your wellness journey\neffortlessly.',
    ),
    OnboardingPageData(
      image: AppImages.frameImage2,
      title: 'All Your Health Data\nIn One Secure Place',
      description:
      'Access and manage your complete health\ninformation whenever you need it.',
    ),
    OnboardingPageData(
      image: AppImages.frameImage3,
      title: 'Smarter Health Insights\nPowered By AI',
      description:
      'Get meaningful insights and personalized\nrecommendations for better health.',
    ),
    OnboardingPageData(
      image: AppImages.frameImage4,
      title: 'Track Your Progress\nEvery Step Of The Way',
      description:
      'Monitor your health activities and see your\nprogress in a simple way.',
    ),
    OnboardingPageData(
      image: AppImages.frameImage5,
      title: 'Your Health Journey\nStarts Here',
      description:
      'Stay informed, organized and connected\nwith your personal health.',
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;

  Future<void> _goToPreviousPage() async {
    if (_currentPage == 0) {
      await Navigator.maybePop(context);
      return;
    }

    await _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _goToNextPage() async {
    if (_isLastPage) {
      // Apni next screen ka route yahan add karein.
      // Navigator.pushReplacementNamed(context, '/sign-in');
      context.go(AppRoutes.loginScreen);
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlay.style(context),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.lightBackground,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double screenHeight = constraints.maxHeight;
            final double topInset = mediaQuery.padding.top;
            final double bottomInset = mediaQuery.padding.bottom;

            // Screenshot mein white panel takreeban 60.3% height se start hota hai.
            final double panelTop = screenHeight * 0.603;

            final double artworkTop = topInset + 43.h;

            final double artworkHeight =
            (panelTop - artworkTop + 38.h)
                .clamp(300.h, 510.h)
                .toDouble();

            final double navigationBottom =
            bottomInset > 10.h ? bottomInset + 12.h : 28.h;

            return Stack(
              children: [
                // Background
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.46, 0.70, 1.0],
                        colors: isDark
                            ? const [
                          Color(0xFF111827),
                          Color(0xFF111827),
                          Color(0xFF0F172A),
                          Color(0xFF0B1120),
                        ]
                            : const [
                          Color(0xFFE9FFF9),
                          Color(0xFFF0FFFB),
                          Color(0xFFF9FFFD),
                          Color(0xFFFFFFFF),
                        ],
                      ),
                    ),
                  ),
                ),

                // Soft decorative mint shape
                Positioned(
                  top: -120.h,
                  right: -115.w,
                  child: Container(
                    width: 310.w,
                    height: 445.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDF8EA).withOpacity(0.38),
                      borderRadius: BorderRadius.circular(190.r),
                    ),
                  ),
                ),

                // Pages
                PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];

                    return Stack(
                      children: [
                        // Main onboarding illustration
                        Positioned(
                          top: artworkTop,
                          left: 14.w,
                          right: 14.w,
                          height: artworkHeight,
                          child: Image.asset(
                            page.image,
                            width: double.infinity,
                            height: artworkHeight,
                            fit: BoxFit.contain,
                            alignment: Alignment.topCenter,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (
                                context,
                                error,
                                stackTrace,
                                ) {
                              return const _ImageErrorPlaceholder();
                            },
                          ),
                        ),

                        // Bottom white content section
                        Positioned(
                          top: panelTop,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: _BottomContentPanel(
                            page: page,
                            bottomPadding: navigationBottom,
                            isLastPage: index == _pages.length - 1,
                            onPrevious: _goToPreviousPage,
                            onNext: _goToNextPage,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Top progress indicator
                Positioned(
                  top: topInset + 14.h,
                  left: 17.w,
                  right: 17.w,
                  child: _OnboardingProgressIndicator(
                    itemCount: _pages.length,
                    currentIndex: _currentPage,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomContentPanel extends StatelessWidget {
  final OnboardingPageData page;
  final double bottomPadding;
  final bool isLastPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _BottomContentPanel({
    required this.page,
    required this.bottomPadding,
    required this.isLastPage,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    final Color panelColor = isDark
        ? const Color(0xFF111827)
        : Colors.white;

    final Color titleColor = isDark
        ? Colors.white
        : const Color(0xFF1D2939);

    final Color descriptionColor = isDark
        ? Colors.white.withValues(alpha: 0.68)
        : const Color(0xFF667085);

    final Color borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.transparent;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
        ),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: isDark
            ? null
            : <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 33.h,
            left: 22.w,
            right: 22.w,
            child: Text(
              page.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 28.sp,
                height: 1.06,
                letterSpacing: -0.7,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
          ),

          Positioned(
            top: 127.h,
            left: 24.w,
            right: 24.w,
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.45,
                fontWeight: FontWeight.w400,
                color: descriptionColor,
              ),
            ),
          ),

          Positioned(
            bottom: bottomPadding,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _CircularNavigationButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: onPrevious,
                ),
                SizedBox(width: 24.w),
                _CircularNavigationButton(
                  icon: isLastPage
                      ? Icons.check_rounded
                      : Icons.chevron_right_rounded,
                  onPressed: onNext,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _CircularNavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircularNavigationButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1D2939),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(0.15),
        highlightColor: Colors.white.withOpacity(0.07),
        child: SizedBox(
          width: 64.w,
          height: 64.w,
          child: Icon(
            icon,
            size: 32.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _OnboardingProgressIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _OnboardingProgressIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        itemCount,
            (index) {
          final bool isSelected = index <= currentIndex;

          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              height: 3.h,
              margin: EdgeInsets.only(
                right: index == itemCount - 1 ? 0 : 6.w,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF14B8A6)
                    : const Color(0xFFDCEFEA),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImageErrorPlaceholder extends StatelessWidget {
  const _ImageErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 310.w,
        height: 365.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.65),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.25),
          ),
        ),
        child: Icon(
          Icons.health_and_safety_outlined,
          size: 70.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

