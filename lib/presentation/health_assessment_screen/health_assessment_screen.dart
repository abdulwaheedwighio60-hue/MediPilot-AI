import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';

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
  static const Color _primaryColor = Color(0xFF19BFAF);
  static const Color _darkTextColor = Color(0xFF1F2937);
  static const Color _secondaryTextColor = Color(0xFF7B8494);
  static const Color _borderColor = Color(0xFFE7EAF0);
  static const Color _softBackgroundColor = Color(0xFFF8FAFB);

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
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Please select your gender.'),
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
              content: Text(
                '$_selectedPlan plan selected successfully.',
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
      canPop:
      _currentStep == HealthAssessmentStep.assessment,
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
          backgroundColor: Colors.white,
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12.w,
        10.h,
        12.w,
        8.h,
      ),
      color: Colors.white,
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
                  (_currentStep.index /
                      (_stepLabels.length - 1));

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
                    color: _borderColor,
                  ),
                ),

                AnimatedPositioned(
                  duration:
                  const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  top: 11.h,
                  left: lineStart,
                  width: activeLineWidth,
                  child: Container(
                    height: 2.h,
                    color: _primaryColor,
                  ),
                ),

                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: List<Widget>.generate(
                    _stepLabels.length,
                        (int index) {
                      return Expanded(
                        child: _StepHeaderItem(
                          label: _stepLabels[index],
                          index: index,
                          currentIndex:
                          _currentStep.index,
                          primaryColor: _primaryColor,
                          borderColor: _borderColor,
                          textColor: _darkTextColor,
                          inactiveTextColor:
                          _secondaryTextColor,
                          onTap: () {
                            /*
                              Users may return to a completed step,
                              but cannot skip an incomplete step.
                            */
                            if (index <=
                                _currentStep.index) {
                              _changeStep(
                                HealthAssessmentStep
                                    .values[index],
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

                const _HealthAssessmentIllustration(),

                SizedBox(height: 34.h),

                Text(
                  "Let's take a quick health\nassessment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _darkTextColor,
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
                    color: _secondaryTextColor,
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
                color: _darkTextColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Your information helps us personalize your health experience.',
              style: TextStyle(
                color: _secondaryTextColor,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),

            SizedBox(height: 28.h),

            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[
                AutofillHints.name,
              ],
              onFieldSubmitted: (_) {
                _ageFocusNode.requestFocus();
              },
              validator: (String? value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your full name';
                }

                if (value.trim().length < 2) {
                  return 'Please enter a valid name';
                }

                return null;
              },
              decoration: _inputDecoration(
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline_rounded,
              ),
            ),

            SizedBox(height: 16.h),

            TextFormField(
              controller: _ageController,
              focusNode: _ageFocusNode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
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
              decoration: _inputDecoration(
                label: 'Age',
                hint: 'Enter your age',
                icon: Icons.calendar_today_outlined,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'Gender',
              style: TextStyle(
                color: _darkTextColor,
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
                  selectedColor: _primaryColor,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: selected
                        ? _primaryColor
                        : _borderColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(30.r),
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : _darkTextColor,
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

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    OutlineInputBorder buildBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: color),
      );
    }

    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        size: 21.sp,
        color: _secondaryTextColor,
      ),
      filled: true,
      fillColor: _softBackgroundColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 16.h,
      ),
      border: buildBorder(_borderColor),
      enabledBorder: buildBorder(_borderColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(
          color: _primaryColor,
          width: 1.5,
        ),
      ),
      errorBorder: buildBorder(Colors.redAccent),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

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
              color: _darkTextColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'Select the plan that best supports your health goals.',
            style: TextStyle(
              color: _secondaryTextColor,
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 24.h),

          _PlanOptionCard(
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
            primaryColor: _primaryColor,
            borderColor: _borderColor,
            darkTextColor: _darkTextColor,
            secondaryTextColor: _secondaryTextColor,
            onTap: () {
              setState(() {
                _selectedPlan = 'Basic';
              });
            },
          ),

          SizedBox(height: 14.h),

          _PlanOptionCard(
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
            primaryColor: _primaryColor,
            borderColor: _borderColor,
            darkTextColor: _darkTextColor,
            secondaryTextColor: _secondaryTextColor,
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
      child: Padding(
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
              backgroundColor: _primaryColor,
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

class _StepHeaderItem extends StatelessWidget {
  const _StepHeaderItem({
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.primaryColor,
    required this.borderColor,
    required this.textColor,
    required this.inactiveTextColor,
    required this.onTap,
  });

  final String label;
  final int index;
  final int currentIndex;
  final Color primaryColor;
  final Color borderColor;
  final Color textColor;
  final Color inactiveTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool completed = index < currentIndex;
    final bool current = index == currentIndex;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 23.w,
            height: 23.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: completed
                  ? primaryColor
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: current || completed
                    ? primaryColor
                    : borderColor,
                width: current ? 2 : 1.5,
              ),
              boxShadow: current
                  ? <BoxShadow>[
                BoxShadow(
                  color:
                  primaryColor.withValues(alpha: 0.14),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
                  : null,
            ),
            child: completed
                ? Icon(
              Icons.check_rounded,
              size: 14.sp,
              color: Colors.white,
            )
                : Container(
              width: current ? 7.w : 5.w,
              height: current ? 7.w : 5.w,
              decoration: BoxDecoration(
                color: current
                    ? primaryColor
                    : borderColor,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: current
                  ? textColor
                  : inactiveTextColor,
              fontSize: 11.sp,
              fontWeight: current
                  ? FontWeight.w700
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthAssessmentIllustration extends StatelessWidget {
  const _HealthAssessmentIllustration();

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
            child: _IllustrationLine(width: 76.w),
          ),

          Positioned(
            top: 83.h,
            right: 2.w,
            child: _IllustrationLine(width: 40.w),
          ),

          Positioned(
            top: 101.h,
            left: 6.w,
            child: _IllustrationLine(width: 114.w),
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
            child: _IllustrationLine(width: 72.w),
          ),

          Positioned(
            top: 199.h,
            left: 6.w,
            child: _IllustrationLine(width: 112.w),
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

class _IllustrationLine extends StatelessWidget {
  const _IllustrationLine({
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

class _PlanOptionCard extends StatelessWidget {
  const _PlanOptionCard({
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.selected,
    required this.primaryColor,
    required this.borderColor,
    required this.darkTextColor,
    required this.secondaryTextColor,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool selected;
  final Color primaryColor;
  final Color borderColor;
  final Color darkTextColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: EdgeInsets.all(18.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: selected
                  ? primaryColor
                  : borderColor,
              width: selected ? 1.7 : 1,
            ),
            boxShadow: selected
                ? <BoxShadow>[
              BoxShadow(
                color:
                primaryColor.withValues(alpha: 0.10),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ]
                : null,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: darkTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  if (badge != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius:
                        BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                  SizedBox(width: 10.w),

                  Container(
                    width: 23.w,
                    height: 23.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? primaryColor
                            : borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: selected
                        ? Icon(
                      Icons.check_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    price,
                    style: TextStyle(
                      color: darkTextColor,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      period,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              Text(
                description,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 12.sp,
                  height: 1.45,
                ),
              ),

              SizedBox(height: 16.h),

              ...features.map(
                    (String feature) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(
                              alpha: 0.12,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 13.sp,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: darkTextColor,
                              fontSize: 12.sp,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
