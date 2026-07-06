import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/core/validators/app_input_validators.dart';
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
  final GlobalKey<FormState> _personalInfoFormKey =
  GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController();
  final TextEditingController _ageController =
  TextEditingController();

  final FocusNode _nameFocusNode =
  FocusNode(debugLabel: 'healthAssessmentName');
  final FocusNode _ageFocusNode =
  FocusNode(debugLabel: 'healthAssessmentAge');

  HealthAssessmentStep _currentStep =
      HealthAssessmentStep.assessment;

  String? _selectedGender;
  String _selectedPlan = 'Premium';

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
        ? AppColors.darkBackground
        : AppColors.lightBackground;
  }

  Color _surfaceColor(BuildContext context) {
    return _isDark(context)
        ? AppColors.darkCard
        : AppColors.lightCard;
  }

  Color _primaryTextColor(BuildContext context) {
    return _isDark(context)
        ? Colors.white
        : AppColors.darkTextPrimary;
  }

  Color _secondaryTextColor(BuildContext context) {
    return _isDark(context)
        ? Colors.white.withValues(alpha: 0.70)
        : AppColors.darkTextSecondary;
  }

  Color _borderColor(BuildContext context) {
    return _isDark(context)
        ? Colors.white.withValues(alpha: 0.14)
        : AppColors.borderColor;
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

  void _handlePrimaryButton() {
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
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: _surfaceColor(context),
              content: Text(
                '$_selectedPlan plan selected successfully.',
                style: TextStyle(
                  color: _primaryTextColor(context),
                ),
              ),
            ),
          );

        // TODO: Call your API or navigate to the dashboard.
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
        return 'Get Started';
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
        ? AppColors.darkCard
        : AppColors.lightCard;

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
          final double itemWidth =
              constraints.maxWidth / _stepLabels.length;

          final double lineStart = itemWidth / 2;
          final double totalLineWidth =
              constraints.maxWidth - itemWidth;

          final double activeLineWidth =
              totalLineWidth *
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
                  style: TextStyle(
                    color: _primaryTextColor(context),
                    fontSize: 25.sp,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 14.h),

                Text(
                  'This should take around 1–2 minutes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _secondaryTextColor(context),
                    fontSize: 13.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
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
    return SingleChildScrollView(
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
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
              style: TextStyle(
                color: _primaryTextColor(context),
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Your information helps us personalize your health experience.',
              style: TextStyle(
                color: _secondaryTextColor(context),
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),

            SizedBox(height: 28.h),

            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: _primaryTextColor(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              autofillHints: const <String>[
                AutofillHints.name,
              ],
              onFieldSubmitted: (_) {
                _ageFocusNode.requestFocus();
              },
              validator: AppInputValidators.email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_rounded),
                hintText: 'Enter your full name',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
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
                color: _primaryTextColor(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (String? value) {
                final int? age =
                int.tryParse(value?.trim() ?? '');

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
                prefixIcon: Icon(Icons.calendar_today_outlined),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'Gender',
              style: TextStyle(
                color: _primaryTextColor(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
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
                final bool selected =
                    _selectedGender == gender;

                return ChoiceChip(
                  label: Text(gender),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: AppColors.primaryLight,
                  backgroundColor: _surfaceColor(context),
                  side: BorderSide(
                    color: selected
                        ? AppColors.primaryLight
                        : _borderColor(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : _primaryTextColor(context),
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

  // InputDecoration _inputDecoration({
  //   required String label,
  //   required String hint,
  //   required IconData icon,
  // }) {
  //   final Color fillColor = _surfaceColor(context);
  //   final Color borderColor = _borderColor(context);
  //   final Color primaryTextColor = _primaryTextColor(context);
  //   final Color secondaryTextColor = _secondaryTextColor(context);
  //
  //   OutlineInputBorder buildBorder(Color color) {
  //     return OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(14.r),
  //       borderSide: BorderSide(color: color),
  //     );
  //   }
  //
  //   return InputDecoration(
  //     labelText: label,
  //     hintText: hint,
  //     labelStyle: TextStyle(
  //       color: secondaryTextColor,
  //       fontSize: 13.sp,
  //     ),
  //     hintStyle: TextStyle(
  //       color: secondaryTextColor.withValues(alpha: 0.75),
  //       fontSize: 13.sp,
  //     ),
  //     prefixIcon: Icon(
  //       icon,
  //       size: 21.sp,
  //       color: secondaryTextColor,
  //     ),
  //     filled: true,
  //     fillColor: fillColor,
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 14.w,
  //       vertical: 16.h,
  //     ),
  //     border: buildBorder(borderColor),
  //     enabledBorder: buildBorder(borderColor),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(14.r),
  //       borderSide: BorderSide(
  //         color: AppColors.primaryLight,
  //         width: 1.5,
  //       ),
  //     ),
  //     errorBorder: buildBorder(Colors.redAccent),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(14.r),
  //       borderSide: const BorderSide(
  //         color: Colors.redAccent,
  //         width: 1.5,
  //       ),
  //     ),
  //     errorStyle: TextStyle(
  //       color: Colors.redAccent,
  //       fontSize: 11.sp,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     floatingLabelStyle: TextStyle(
  //       color: AppColors.primaryLight,
  //       fontSize: 13.sp,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

  Widget _buildChoosePlanContent() {
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
            style: TextStyle(
              color: _primaryTextColor(context),
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'Select the plan that best supports your health goals.',
            style: TextStyle(
              color: _secondaryTextColor(context),
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 24.h),

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
              backgroundColor: AppColors.primaryLight,
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