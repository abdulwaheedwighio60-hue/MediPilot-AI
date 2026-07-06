import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/core/validators/app_input_validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  late final Listenable _formChanges;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSubmitting = false;

  // static const Color _primaryColor = AppColors.primary;
  // static const Color _darkColor = Color(0xFF1D2939);
  // static const Color _secondaryTextColor = Color(0xFF667085);
  // static const Color _borderColor = Color(0xFFD0D5DD);
  // static const Color _inactiveBarColor = Color(0xFFE4E7EC);

  @override
  void initState() {
    super.initState();
    _formChanges = Listenable.merge([
      _emailController,
      _passwordController,
      _confirmPasswordController,
    ]);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  bool get _isEmailValid {
    final email = _emailController.text.trim();

    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  bool get _passwordsMatch {
    final password = _passwordController.text;
    final confirmation = _confirmPasswordController.text;

    return password.isNotEmpty &&
        confirmation.isNotEmpty &&
        password == confirmation;
  }

  int _calculatePasswordScore(String password) {
    if (password.isEmpty) {
      return 0;
    }

    int score = 0;

    if (password.length >= 8) {
      score++;
    }

    if (RegExp(r'[a-z]').hasMatch(password)) {
      score++;
    }

    if (RegExp(r'[A-Z]').hasMatch(password)) {
      score++;
    }

    if (RegExp(r'[0-9]').hasMatch(password)) {
      score++;
    }

    if (RegExp(
      r'''[!@#$%^&*(),.?":{}|<>_\-+=/\\[\];']''',
    ).hasMatch(password)) {
      score++;
    }

    return score;
  }

  int get _passwordScore {
    return _calculatePasswordScore(
      _passwordController.text,
    );
  }

  bool get _isPasswordStrong => _passwordScore >= 4;

  bool get _canSubmit {
    return _isEmailValid &&
        _isPasswordStrong &&
        _passwordsMatch &&
        !_isSubmitting;
  }

  PasswordStrength _getPasswordStrength(String password) {
    final score = _calculatePasswordScore(password);

    if (password.isEmpty) {
      return PasswordStrength(
        activeSegments: 0,
        label: '',
        message: '',
        color: AppColors.darkTextSecondary,
      );
    }

    if (score <= 2) {
      return const PasswordStrength(
        activeSegments: 1,
        label: 'Weak!',
        message: 'Add Strength! 💪',
        color: Color(0xFFF04438),
      );
    }

    if (score == 3) {
      return const PasswordStrength(
        activeSegments: 3,
        label: 'Good!',
        message: 'Almost there',
        color: Color(0xFFF79009),
      );
    }

    if (score == 4) {
      return const PasswordStrength(
        activeSegments: 4,
        label: 'Strong!',
        message: 'Great password ✅',
        color: Color(0xFF12B76A),
      );
    }

    return const PasswordStrength(
      activeSegments: 5,
      label: 'Amazing!',
      message: 'Excellent strength ✚',
      color: Color(0xFF12B76A),
    );
  }

  Future<void> _signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final isFormValid =
        _formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    if (!_isPasswordStrong) {
      _showMessage(
        message:
        'Please use a stronger password before signing up.',
        isError: true,
      );
      return;
    }

    if (!_passwordsMatch) {
      _showMessage(
        message: 'Password and confirmation do not match.',
        isError: true,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Sign-up API call:
      //
      // await authProvider.signUp(
      //   email: email,
      //   password: password,
      // );


      await Future<void>.delayed(
        const Duration(milliseconds: 900),
      );

      if (!mounted) return;

      _showMessage(
        message: 'Account created successfully.',
        isError: false,
      );

      debugPrint('Sign-up email: $email');
      debugPrint('Password length: ${password.length}');
      context.go(AppRoutes.healthAssessmentScreen);
      // Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      if (!mounted) return;

      _showMessage(
        message:
        'Unable to create account. Please try again.',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showMessage({
    required String message,
    required bool isError,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError
              ? const Color(0xFFF04438)
              : const Color(0xFF12B76A),
          content: Text(message),
        ),
      );
  }

  void _openLoginScreen() {
    FocusManager.instance.primaryFocus?.unfocus();

    // Navigator.pushReplacementNamed(context, '/login');

    Navigator.maybePop(context);
  }

  void _togglePasswordVisibility() {
    final hadFocus = _passwordFocusNode.hasFocus;

    setState(() {
      _obscurePassword = !_obscurePassword;
    });

    if (hadFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _passwordFocusNode.requestFocus();
        }
      });
    }
  }

  void _toggleConfirmPasswordVisibility() {
    final hadFocus = _confirmPasswordFocusNode.hasFocus;

    setState(() {
      _obscureConfirmPassword =
      !_obscureConfirmPassword;
    });

    if (hadFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _confirmPasswordFocusNode.requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlay.style(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.lightBackground,
        body: SafeArea(
          child: Form(
            key: _formKey,

            // Automatic validation typing ke waqt layout ko
            // change nahi karegi.
            autovalidateMode:
            AutovalidateMode.disabled,

            child: ListView(
              padding: EdgeInsets.fromLTRB(
                24.w,
                0,
                24.w,
                28.h,
              ),

              // Important:
              // Keyboard automatic scrolling par dismiss nahi hoga.
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.manual,

              physics: const ClampingScrollPhysics(),

              children: [
                SizedBox(height: 46.h),

                _buildLogo(),

                SizedBox(height: 18.h),

                Text(
                  'Sign Up to access smart medical & e-pharma.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                  // TextStyle(
                  //   color: _secondaryTextColor,
                  //   fontSize: 13.sp,
                  //   height: 1.4,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ),

                SizedBox(height: 50.h),

                 _FieldLabel(
                  label: 'Email Address',
                ),

                SizedBox(height: 7.h),

                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,

                  // Password autofill conflict avoid karne ke liye
                  // currently disabled rakha hai.
                  autofillHints: null,

                  keyboardType:
                  TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColors.primary,
                  autocorrect: false,
                  enableSuggestions: false,
                  scrollPadding: EdgeInsets.only(
                    bottom: 110.h,
                  ),
                  onFieldSubmitted: (_) {
                    _passwordFocusNode.requestFocus();
                  },
                  validator: AppInputValidators.email,
                  style: textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText:
                    'Enter your email address...',
                    hintStyle: textTheme.bodySmall?.copyWith(
                      fontSize: 13.sp,
                    ),
                    prefixIcon:
                    Icon(Icons.mail_outline_rounded),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                const _FieldLabel(
                  label: 'Password',
                ),

                SizedBox(height: 7.h),

                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  autofillHints: null,
                  obscureText: _obscurePassword,
                  obscuringCharacter: '•',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: AppColors.primary,
                  autocorrect: false,
                  enableSuggestions: false,
                  smartDashesType:
                  SmartDashesType.disabled,
                  smartQuotesType:
                  SmartQuotesType.disabled,
                  enableIMEPersonalizedLearning: false,
                  scrollPadding: EdgeInsets.only(
                    bottom: 130.h,
                  ),
                  onFieldSubmitted: (_) {
                    _confirmPasswordFocusNode
                        .requestFocus();
                  },
                  validator: AppInputValidators.password,
                  style: textTheme.bodySmall?.copyWith(
                    letterSpacing: 1.1,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: textTheme.bodySmall,
                    prefixIcon:
                    Icon(Icons.lock_outline_rounded),
                    suffixIcon:
                    _PasswordVisibilityButton(
                      isObscured: _obscurePassword,
                      onPressed:
                      _togglePasswordVisibility,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                  ),
                ),

                SizedBox(height: 7.h),

                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _passwordController,
                  builder: (
                      context,
                      passwordValue,
                      child,
                      ) {
                    return _PasswordStrengthIndicator(
                      strength: _getPasswordStrength(
                        passwordValue.text,
                      ),
                    );
                  },
                ),

                SizedBox(height: 19.h),

                const _FieldLabel(
                  label: 'Password Confirmation',
                ),

                SizedBox(height: 7.h),

                TextFormField(
                  key: const ValueKey(
                    'confirm-password-field',
                  ),
                  controller:
                  _confirmPasswordController,
                  focusNode:
                  _confirmPasswordFocusNode,
                  autofillHints: null,
                  obscureText:
                  _obscureConfirmPassword,
                  obscuringCharacter: '•',
                  keyboardType: TextInputType.text,
                  textInputAction:
                  TextInputAction.done,
                  cursorColor: AppColors.primary,
                  autocorrect: false,
                  enableSuggestions: false,
                  smartDashesType:
                  SmartDashesType.disabled,
                  smartQuotesType:
                  SmartQuotesType.disabled,
                  enableIMEPersonalizedLearning: false,

                  // Keyboard khulne ke baad field automatically
                  // proper visible area mein rahegi.
                  scrollPadding: EdgeInsets.only(
                    bottom: 160.h,
                  ),

                  onFieldSubmitted: (_) {
                    if (_canSubmit) {
                      _signUp();
                    }
                  },
                  validator: AppInputValidators.strongPassword,
                  style: textTheme.bodySmall?.copyWith(
                    letterSpacing: 1.1,
                  ),
                  decoration: InputDecoration(
                    hintText:
                    'Confirm your password',
                    hintStyle: textTheme.bodySmall,
                    prefixIcon:

                    Icon(Icons.lock_outline_rounded),
                    suffixIcon:
                    _PasswordVisibilityButton(
                      isObscured:
                      _obscureConfirmPassword,
                      onPressed:
                      _toggleConfirmPasswordVisibility,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                  ),

                ),

                SizedBox(height: 28.h),

                AnimatedBuilder(
                  animation: _formChanges,
                  builder: (context, child) {
                    final canSubmit = _canSubmit;

                    return SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed:
                        canSubmit ? _signUp : null,
                        style:
                        ElevatedButton.styleFrom(
                          elevation: 0,
                          shadowColor:
                          Colors.transparent,
                          backgroundColor:
                          AppColors.primary,
                          disabledBackgroundColor:
                          AppColors.primaryLight,
                          foregroundColor:
                          Colors.white,
                          disabledForegroundColor:
                          AppColors.primaryLight,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              13.r,
                            ),
                          ),
                        ),
                        child: _isSubmitting
                            ? SizedBox(
                          width: 21.w,
                          height: 21.w,
                          child:
                          const CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                              Colors.white,
                            ),
                          ),
                        )
                            : Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Icon(
                              Icons.login_rounded,
                              size: 17.sp,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 50.h),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _openLoginScreen,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                        textTheme.bodySmall,
                        // TextStyle(
                        //   color: AppColors.darkTextSecondary,
                        //   fontSize: 12.sp,
                        //   fontWeight: FontWeight.w400,
                        // ),
                        children:  [
                          TextSpan(
                            text: 'I already have ',
                          ),
                          TextSpan(
                            text: 'an account',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          AppImages.appLogo,
          width: 38.w,
          height: 38.w,
          fit: BoxFit.contain,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return Icon(
              Icons.local_hospital_outlined,
              size: 38.sp,
              color: AppColors.primary,
            );
          },
        ),
        SizedBox(height: 7.h),
        Text(
          'nightingale',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            height: 1,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.w,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: textTheme.bodySmall?.copyWith(
            fontSize: 13.5.sp,
            height: 1,
            fontWeight: FontWeight.w500,
        ),

        // TextStyle(
        //   color: const Color(0xFF1D2939),
        //   fontSize: 12.5.sp,
        //   height: 1,
        //   fontWeight: FontWeight.w500,
        // ),
      ),
    );
  }
}

class _PasswordVisibilityButton extends StatelessWidget {
  final bool isObscured;
  final VoidCallback onPressed;

  const _PasswordVisibilityButton({
    required this.isObscured,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.r,
      tooltip: isObscured
          ? 'Show password'
          : 'Hide password',
      onPressed: onPressed,
      icon: Icon(
        isObscured
            ? Icons.visibility_rounded
            : Icons.visibility_off_rounded,
        size: 18.sp,
        color: const Color(0xFF98A2B3),
      ),
    );
  }
}

class _PasswordStrengthIndicator
    extends StatelessWidget {
  final PasswordStrength strength;

  const _PasswordStrengthIndicator({
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            5,
                (index) {
              final isActive =
                  index < strength.activeSegments;

              return Expanded(
                child: AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  height: 4.h,
                  margin: EdgeInsets.only(
                    right: index == 4 ? 0 : 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? strength.color
                        : const Color(0xFFE4E7EC),
                    borderRadius:
                    BorderRadius.circular(20.r),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 7.h),
        SizedBox(
          height: 16.h,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedSwitcher(
              duration:
              const Duration(milliseconds: 200),
              child: strength.label.isEmpty
                  ? const SizedBox.shrink()
                  : RichText(
                key: ValueKey(
                  '${strength.label}-${strength.message}',
                ),
                text: TextSpan(
                  style: TextStyle(
                    color:
                    const Color(0xFF667085),
                    fontSize: 11.5.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Password strength: ',
                    ),
                    TextSpan(
                      text: strength.label,
                      style: TextStyle(
                        color: strength.color,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                      ' ${strength.message}',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordStrength {
  final int activeSegments;
  final String label;
  final String message;
  final Color color;

  const PasswordStrength({
    required this.activeSegments,
    required this.label,
    required this.message,
    required this.color,
  });
}