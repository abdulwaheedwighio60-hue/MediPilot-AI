import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/presentation/dashboard_screens/dashboard_screen.dart';
import 'package:med_pilot_ai/presentation/health_assessment_screen/widgets/health_assessment_illustration.dart';
import 'package:med_pilot_ai/presentation/health_assessment_screen/widgets/plan_option_card.dart';
import 'package:med_pilot_ai/presentation/health_assessment_screen/widgets/step_header_item.dart';

enum HealthAssessmentStep {
  assessment,
  personalInfo,
  choosePlan,
}

class HealthAssessmentScreen extends StatefulWidget {
  const HealthAssessmentScreen({super.key});

  @override
  State<HealthAssessmentScreen> createState() =>
      _HealthAssessmentScreenState();
}

class _HealthAssessmentScreenState extends State<HealthAssessmentScreen> {
  final GlobalKey<FormState> _personalInfoFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final FocusNode _nameFocusNode =
  FocusNode(debugLabel: 'healthAssessmentName');
  final FocusNode _ageFocusNode =
  FocusNode(debugLabel: 'healthAssessmentAge');

  HealthAssessmentStep _currentStep = HealthAssessmentStep.assessment;

  String? _selectedGender;

  // ✅ CHANGED: default plan capital rakha hai because cards 'Free' se compare kar rahe hain
  String _selectedPlan = 'Free';

  static const List<String> _stepLabels = <String>[
    'Assessment',
    'Personal Info',
    'Choose Plan',
  ];

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBackgroundColor
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

  Color _borderColor(BuildContext context) {
    return _isDark(context) ? AppColors.darkBorder : AppColors.lightBorder;
  }

  double get _selectedPlanAmount {
    switch (_selectedPlan) {
      case 'Basic':
        return 4.99;
      case 'Premium':
        return 9.99;
      case 'Free':
      default:
        return 0.00;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    super.dispose();
  }

  void _changeStep(HealthAssessmentStep step) {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _currentStep = step;
    });
  }

  void _handleBack() {
    switch (_currentStep) {
      case HealthAssessmentStep.assessment:
        Navigator.of(context).maybePop();
        break;

      case HealthAssessmentStep.personalInfo:
        _changeStep(HealthAssessmentStep.assessment);
        break;

      case HealthAssessmentStep.choosePlan:
        _changeStep(HealthAssessmentStep.personalInfo);
        break;
    }
  }
  bool _isNavigating = false;

  void _openFreeAccount() {
    if (_isNavigating) return;

    setState(() {
      _isNavigating = true;
    });

    final String userName = _nameController.text.trim().isEmpty
        ? 'Abdul Waheed'
        : _nameController.text.trim();

    context.go(
      AppRoutes.rootScreen,
      extra: {
        'userName': userName,
        'userPlan': UserPlan.free,
      },
    );
  }

  void _openPaymentMethod() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(
          selectedPlan: _selectedPlan,
          amount: _selectedPlanAmount,
        ),
      ),
    );
  }

  void _handlePrimaryButton() {
    if (_isNavigating) return;

    FocusManager.instance.primaryFocus?.unfocus();

    switch (_currentStep) {
      case HealthAssessmentStep.assessment:
        _changeStep(HealthAssessmentStep.personalInfo);
        break;

      case HealthAssessmentStep.personalInfo:
        final bool isValid =
            _personalInfoFormKey.currentState?.validate() ?? false;

        if (!isValid) {
          return;
        }

        if (_selectedGender == null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: _surfaceColor(context),
                content: Text(
                  'Please select your gender.',
                  style: TextStyle(
                    color: _primaryTextColor(context),
                  ),
                ),
              ),
            );
          return;
        }

        _changeStep(HealthAssessmentStep.choosePlan);
        break;

      case HealthAssessmentStep.choosePlan:
        if (_selectedPlan == 'Free') {
          _openFreeAccount();
          return;
        }

        _openPaymentMethod();
        break;
    }
  }

  String get _buttonText {
    switch (_currentStep) {
      case HealthAssessmentStep.assessment:
        return "I'm Ready";

      case HealthAssessmentStep.personalInfo:
        return 'Continue';

      case HealthAssessmentStep.choosePlan:
        return _selectedPlan == 'Free'
            ? 'Get Started'
            : 'Continue to Payment';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool keyboardVisible =
        MediaQuery.viewInsetsOf(context).bottom > 0;

    return PopScope(
      canPop: _currentStep == HealthAssessmentStep.assessment,
      onPopInvokedWithResult: (
          bool didPop,
          Object? result,
          ) {
        if (!didPop) {
          _handleBack();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUiOverlay.style(context),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: _backgroundColor(context),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                _buildStepHeader(),

                Expanded(
                  child: IndexedStack(
                    index: _currentStep.index,
                    sizing: StackFit.expand,
                    children: <Widget>[
                      _buildAssessmentContent(),
                      _buildPersonalInfoContent(),
                      _buildChoosePlanContent(),
                    ],
                  ),
                ),

                if (!keyboardVisible) _buildBottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader() {
    final Color headerColor = _isDark(context)
        ? AppColors.darkBackgroundColor
        : AppColors.lightBackground;

    final Color activeTextColor = _primaryTextColor(context);
    final Color inactiveTextColor = _secondaryTextColor(context);
    final Color lineColor = _borderColor(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12.w,
        10.h,
        12.w,
        8.h,
      ),
      decoration: BoxDecoration(
        color: headerColor,
        border: Border(
          bottom: BorderSide(
            color: lineColor,
            width: 1,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (
            BuildContext context,
            BoxConstraints constraints,
            ) {
          final double itemWidth = constraints.maxWidth / _stepLabels.length;

          final double lineStart = itemWidth / 2;
          final double totalLineWidth = constraints.maxWidth - itemWidth;

          final double activeLineWidth = totalLineWidth *
              (_currentStep.index / (_stepLabels.length - 1));

          return SizedBox(
            height: 58.h,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 11.h,
                  left: lineStart,
                  width: totalLineWidth,
                  child: Container(
                    height: 2.h,
                    color: lineColor,
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  top: 11.h,
                  left: lineStart,
                  width: activeLineWidth,
                  child: Container(
                    height: 2.h,
                    color: AppColors.primaryLight,
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(
                    _stepLabels.length,
                        (int index) {
                      return Expanded(
                        child: StepHeaderItem(
                          label: _stepLabels[index],
                          index: index,
                          currentIndex: _currentStep.index,
                          primaryColor: AppColors.primaryLight,
                          borderColor: lineColor,
                          textColor: activeTextColor,
                          inactiveTextColor: inactiveTextColor,
                          onTap: () {
                            if (index <= _currentStep.index) {
                              _changeStep(
                                HealthAssessmentStep.values[index],
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssessmentContent() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (
          BuildContext context,
          BoxConstraints constraints,
          ) {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24.w,
            18.h,
            24.w,
            24.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 42.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 8.h),

                const HealthAssessmentIllustration(),

                SizedBox(height: 34.h),

                Text(
                  "Let's take a quick health\nassessment.",
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),

                SizedBox(height: 14.h),

                Text(
                  'This should take around 1–2 minutes.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),

                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonalInfoContent() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color inputTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final Color inputHintColor =
    isDark ? AppColors.darkHint : AppColors.lightHint;

    final Color inputIconColor =
    isDark ? AppColors.iconDark : AppColors.iconLight;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        22.w,
        24.h,
        22.w,
        30.h,
      ),
      child: Form(
        key: _personalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tell us about yourself',
              style: textTheme.headlineMedium,
            ),

            SizedBox(height: 8.h),

            Text(
              'Your information helps us personalize your health experience.',
              style: textTheme.bodySmall,
            ),

            SizedBox(height: 28.h),

            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: inputTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              autofillHints: const <String>[
                AutofillHints.name,
              ],
              onFieldSubmitted: (_) {
                _ageFocusNode.requestFocus();
              },
              validator: (String? value) {
                final String name = value?.trim() ?? '';

                if (name.isEmpty) {
                  return 'Please enter your full name';
                }

                if (name.length < 2) {
                  return 'Name must be at least 2 characters';
                }

                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  color: inputIconColor,
                ),
                hintText: 'Enter your full name',
                hintStyle: TextStyle(
                  color: inputHintColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            TextFormField(
              controller: _ageController,
              focusNode: _ageFocusNode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                color: inputTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (String? value) {
                final int? age = int.tryParse(value?.trim() ?? '');

                if (age == null) {
                  return 'Please enter your age';
                }

                if (age < 13 || age > 120) {
                  return 'Please enter a valid age';
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your age',
                prefixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: inputIconColor,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
                hintStyle: TextStyle(
                  color: inputHintColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'Gender',
              style: textTheme.bodyLarge,
            ),

            SizedBox(height: 12.h),

            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: <String>[
                'Male',
                'Female',
                'Other',
              ].map((String gender) {
                final bool selected = _selectedGender == gender;
                final bool isDark =
                    Theme.of(context).brightness == Brightness.dark;

                final Color selectedTextColor =
                isDark ? AppColors.darkBackground : AppColors.white;

                final Color unselectedTextColor = isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextPrimary;

                final Color selectedChipColor = AppColors.primary;

                final Color unselectedChipColor =
                isDark ? AppColors.darkSurface : AppColors.lightSurface;

                return ChoiceChip(
                  label: Text(gender),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: selectedChipColor,
                  backgroundColor: unselectedChipColor,
                  side: BorderSide(
                    color: selected ? selectedChipColor : _borderColor(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  labelStyle: TextStyle(
                    color:
                    selected ? selectedTextColor : unselectedTextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  onSelected: (_) {
                    setState(() {
                      _selectedGender = gender;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePlanContent() {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        22.w,
        24.h,
        22.w,
        30.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Choose your plan',
            style: textTheme.titleLarge,
          ),

          SizedBox(height: 8.h),

          Text(
            'Select the plan that best supports your health goals.',
            style: textTheme.bodyMedium,
          ),

          SizedBox(height: 24.h),

          PlanOptionCard(
            title: 'Free',
            price: '\$0',
            period: '/month',
            description:
            'Start your health journey with limited free features.',
            features: const <String>[
              'Basic health assessment',
              'Limited health reminders',
              'Basic profile setup',
            ],
            selected: _selectedPlan == 'Free',
            primaryColor: AppColors.primaryLight,
            borderColor: _borderColor(context),
            onTap: () {
              setState(() {
                _selectedPlan = 'Free';
              });
            },
          ),

          SizedBox(height: 14.h),

          PlanOptionCard(
            title: 'Basic',
            price: '\$4.99',
            period: '/month',
            description:
            'Essential health tracking and personalized insights.',
            features: const <String>[
              'Health assessment',
              'Daily health reminders',
              'Basic progress tracking',
            ],
            selected: _selectedPlan == 'Basic',
            primaryColor: AppColors.primaryLight,
            borderColor: _borderColor(context),
            onTap: () {
              setState(() {
                _selectedPlan = 'Basic';
              });
            },
          ),

          SizedBox(height: 14.h),

          PlanOptionCard(
            title: 'Premium',
            price: '\$9.99',
            period: '/month',
            description:
            'Complete health guidance with advanced AI insights.',
            badge: 'RECOMMENDED',
            features: const <String>[
              'Everything in Basic',
              'Advanced AI insights',
              'Personalized care plan',
              'Priority support',
            ],
            selected: _selectedPlan == 'Premium',
            primaryColor: AppColors.primaryLight,
            borderColor: _borderColor(context),
            onTap: () {
              setState(() {
                _selectedPlan = 'Premium';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          border: Border(
            top: BorderSide(
              color: _borderColor(context),
              width: 1,
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          20.w,
          10.h,
          20.w,
          18.h,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: _handlePrimaryButton,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              _buttonText,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({
    super.key,
    required this.selectedPlan,
    required this.amount,
  });

  final String selectedPlan;
  final double amount;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPaymentMethod = 'Card';

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkBackgroundColor
        : AppColors.lightBackground;
  }

  Color _cardColor(BuildContext context) {
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

  Color _borderColor(BuildContext context) {
    return _isDark(context) ? AppColors.darkBorder : AppColors.lightBorder;
  }

  void _completePayment() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _cardColor(context),
          content: Text(
            '${widget.selectedPlan} plan activated successfully.',
            style: TextStyle(
              color: _primaryTextColor(context),
            ),
          ),
        ),
      );

    Future<void>.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      // Apne home route ke hisaab se '/home' ko adjust kar lena.
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlay.style(context),
      child: Scaffold(
        backgroundColor: _backgroundColor(context),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: _backgroundColor(context),
          foregroundColor: _primaryTextColor(context),
          title: Text(
            'Payment Method',
            style: TextStyle(
              color: _primaryTextColor(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              22.w,
              20.h,
              22.w,
              30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Complete your subscription',
                  style: TextStyle(
                    color: _primaryTextColor(context),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Choose a payment method to activate your ${widget.selectedPlan} plan.',
                  style: TextStyle(
                    color: _secondaryTextColor(context),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    color: _cardColor(context),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: _borderColor(context),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${widget.selectedPlan} Plan',
                          style: TextStyle(
                            color: _primaryTextColor(context),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      Text(
                        '\$${widget.amount.toStringAsFixed(2)}/month',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                Text(
                  'Payment Method',
                  style: TextStyle(
                    color: _primaryTextColor(context),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 12.h),

                _paymentOption(
                  title: 'Credit / Debit Card',
                  subtitle: 'Pay securely using your bank card',
                  icon: Icons.credit_card_rounded,
                  value: 'Card',
                ),

                SizedBox(height: 12.h),

                _paymentOption(
                  title: 'PayPal',
                  subtitle: 'Pay using your PayPal account',
                  icon: Icons.account_balance_wallet_outlined,
                  value: 'PayPal',
                ),

                SizedBox(height: 12.h),

                _paymentOption(
                  title: 'Apple Pay / Google Pay',
                  subtitle: 'Fast checkout using your wallet',
                  icon: Icons.account_balance_rounded,
                  value: 'Wallet',
                ),

                SizedBox(height: 28.h),

                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: _completePayment,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'Pay \$${widget.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final bool selected = _selectedPaymentMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: _cardColor(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.primary : _borderColor(context),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 42.w,
              height: 42.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 22.sp,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: _primaryTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: _secondaryTextColor(context),
                      fontSize: 12.sp,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color:
              selected ? AppColors.primary : _secondaryTextColor(context),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}