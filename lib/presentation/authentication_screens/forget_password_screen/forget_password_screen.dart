import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pilot_ai/core/constants/app_colors.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
import 'package:med_pilot_ai/core/widgets/custom_app_bar_widget.dart';
import 'package:med_pilot_ai/presentation/authentication_screens/forget_password_screen/widget/action_menu_tile.dart';

enum ForgetPasswordStep {
  methodSelection,
  enterDetails,
  success,
}

enum RecoveryMethod {
  email,
  sms,
  twoFactor,
}

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  // Keep one permanent FocusNode for the lifetime of this screen.
  // This prevents the keyboard from closing when MediaQuery rebuilds
  // after the keyboard opens.
  final FocusNode _inputFocusNode = FocusNode(
    debugLabel: 'forgetPasswordInput',
  );

  ForgetPasswordStep _currentStep =
      ForgetPasswordStep.methodSelection;

  RecoveryMethod? _selectedMethod;

  bool _isLoading = false;
  bool _validationEnabled = false;

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _selectMethod(RecoveryMethod method) {
    FocusManager.instance.primaryFocus?.unfocus();
    _inputController.clear();

    setState(() {
      _selectedMethod = method;
      _validationEnabled = false;
      _currentStep = ForgetPasswordStep.enterDetails;
    });

    // Wait until the input step has rendered, then open the keyboard.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _inputFocusNode.requestFocus();
    });
  }

  void _handleBack() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_currentStep == ForgetPasswordStep.methodSelection) {
      Navigator.of(context).maybePop();
      return;
    }

    setState(() {
      _inputController.clear();
      _validationEnabled = false;
      _selectedMethod = null;
      _currentStep = ForgetPasswordStep.methodSelection;
    });
  }

  Future<void> _submitRecoveryRequest() async {
    if (_isLoading) return;

    setState(() {
      _validationEnabled = true;
    });

    final bool isValid =
        _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      _inputFocusNode.requestFocus();
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final String enteredValue =
      _inputController.text.trim();

      switch (_selectedMethod) {
        case RecoveryMethod.email:
        // TODO: Call forgot-password-by-email API.
          debugPrint('Email recovery: $enteredValue');
          break;

        case RecoveryMethod.sms:
        // TODO: Call forgot-password-by-phone API.
          debugPrint('SMS recovery: $enteredValue');
          break;

        case RecoveryMethod.twoFactor:
        // TODO: Call verify-2FA API.
          debugPrint('2FA recovery: $enteredValue');
          break;

        case null:
          throw StateError(
            'Recovery method is not selected.',
          );
      }

      // Remove this delay after integrating the real API.
      await Future<void>.delayed(
        const Duration(seconds: 1),
      );

      if (!mounted) return;

      setState(() {
        _currentStep = ForgetPasswordStep.success;
      });
    } catch (error, stackTrace) {
      debugPrint('Forgot-password error: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Unable to process your request. Please try again.',
            ),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String get _inputLabel {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Email Address';

      case RecoveryMethod.sms:
        return 'Phone Number';

      case RecoveryMethod.twoFactor:
        return 'Authentication Code';

      case null:
        return 'Recovery Detail';
    }
  }

  String get _inputHint {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Enter your registered email address';

      case RecoveryMethod.sms:
        return 'Enter your registered phone number';

      case RecoveryMethod.twoFactor:
        return 'Enter your 6-digit authentication code';

      case null:
        return '';
    }
  }

  String get _inputDescription {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Enter your registered email address and we will send you a password reset link.';

      case RecoveryMethod.sms:
        return 'Enter your registered phone number and we will send you a verification code.';

      case RecoveryMethod.twoFactor:
        return 'Enter the 6-digit code generated by your authenticator application.';

      case null:
        return '';
    }
  }

  String get _submitButtonText {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Send Reset Link';

      case RecoveryMethod.sms:
        return 'Send Verification Code';

      case RecoveryMethod.twoFactor:
        return 'Verify Code';

      case null:
        return 'Continue';
    }
  }

  String get _successTitle {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Password Reset Sent';

      case RecoveryMethod.sms:
        return 'Verification Code Sent';

      case RecoveryMethod.twoFactor:
        return 'Verification Successful';

      case null:
        return 'Request Successful';
    }
  }

  String get _successDescription {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Please check your inbox. We have sent a password reset link to your registered email address.';

      case RecoveryMethod.sms:
        return 'Please check your phone. We have sent a verification code to your registered mobile number.';

      case RecoveryMethod.twoFactor:
        return 'Your identity has been verified. You may now continue to create a new password.';

      case null:
        return '';
    }
  }

  String get _successButtonText {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return 'Open My Email';

      case RecoveryMethod.sms:
        return 'Continue';

      case RecoveryMethod.twoFactor:
        return 'Reset Password';

      case null:
        return 'Continue';
    }
  }

  String get _selectedMethodImage {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return AppImages.lockIcon;

      case RecoveryMethod.sms:
        return AppImages.smsIcon;

      case RecoveryMethod.twoFactor:
        return AppImages.lockIcon;

      case null:
        return AppImages.lockIcon;
    }
  }

  IconData get _fieldIcon {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return CupertinoIcons.mail;

      case RecoveryMethod.sms:
        return CupertinoIcons.device_phone_portrait;

      case RecoveryMethod.twoFactor:
        return Iconsax.key;

      case null:
        return CupertinoIcons.lock;
    }
  }

  Color get _selectedMethodColor {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return AppColors.success;

      case RecoveryMethod.sms:
        return AppColors.error;

      case RecoveryMethod.twoFactor:
        return AppColors.containerColor;

      case null:
        return AppColors.success;
    }
  }

  TextInputType get _keyboardType {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return TextInputType.emailAddress;

      case RecoveryMethod.sms:
        return TextInputType.phone;

      case RecoveryMethod.twoFactor:
        return TextInputType.number;

      case null:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? get _inputFormatters {
    switch (_selectedMethod) {
      case RecoveryMethod.sms:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9+]'),
          ),
          LengthLimitingTextInputFormatter(15),
        ];

      case RecoveryMethod.twoFactor:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ];

      case RecoveryMethod.email:
      case null:
        return null;
    }
  }

  Iterable<String>? get _autofillHints {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
        return const <String>[
          AutofillHints.email,
        ];

      case RecoveryMethod.sms:
        return const <String>[
          AutofillHints.telephoneNumber,
        ];

      case RecoveryMethod.twoFactor:
      case null:
        return null;
    }
  }

  String? _validateInput(String? value) {
    final String input = value?.trim() ?? '';

    if (input.isEmpty) {
      return '$_inputLabel is required';
    }

    switch (_selectedMethod) {
      case RecoveryMethod.email:
        final RegExp emailRegex = RegExp(
          r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
        );

        if (!emailRegex.hasMatch(input)) {
          return 'Please enter a valid email address';
        }
        break;

      case RecoveryMethod.sms:
        final String digitsOnly =
        input.replaceAll(RegExp(r'[^0-9]'), '');

        if (digitsOnly.length < 10) {
          return 'Please enter a valid phone number';
        }
        break;

      case RecoveryMethod.twoFactor:
        if (input.length != 6) {
          return 'Please enter a valid 6-digit code';
        }
        break;

      case null:
        return 'Please select a recovery method';
    }

    return null;
  }

  void _handleSuccessButton() {
    switch (_selectedMethod) {
      case RecoveryMethod.email:
      // TODO: Open email application using url_launcher.
        debugPrint('Open email application');
        break;

      case RecoveryMethod.sms:
      // TODO: Continue to OTP verification.
        debugPrint('Continue SMS verification');
        break;

      case RecoveryMethod.twoFactor:
      // TODO: Navigate to CreateNewPasswordScreen.
        debugPrint('Navigate to reset-password screen');
        break;

      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop:
      _currentStep == ForgetPasswordStep.methodSelection,
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
          backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.lightBackground,

          appBar: CustomAppBarWidget(
            showBackButton: true,
            backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.lightBackground,

            foregroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.lightBackground,
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),

              // IndexedStack keeps all steps mounted.
              // The TextFormField is not destroyed when the keyboard
              // changes MediaQuery/viewInsets, so focus remains stable.
              child: IndexedStack(
                index: _currentStep.index,
                sizing: StackFit.expand,
                children: <Widget>[
                  _buildMethodSelection(context),
                  _buildInputStep(context, isDark),
                  _buildSuccessStep(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodSelection(BuildContext context) {
    final TextTheme textTheme =
        Theme.of(context).textTheme;
    final isDark1 = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.manual,
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.h),
          Text(
            'Forgot Password',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Choose how you would like to verify your identity and reset your password.',
            style: textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          ActionMenuTile(
            title: 'Send via Email',
            icon: CupertinoIcons.mail,
            backgroundColor: isDark1 ? AppColors.darkCard : AppColors.lightCard,            iconColor: AppColors.success,
            borderColor: isDark1 ? AppColors.darkBorder : AppColors.lightBorder,
            onTap: () {
              _selectMethod(RecoveryMethod.email);
            },
          ),
          SizedBox(height: 10.h),
          ActionMenuTile(
            title: 'Send via SMS',
            icon: CupertinoIcons.device_phone_portrait,
            iconColor: AppColors.error,
            iconBackgroundColor:
            AppColors.error.withValues(alpha: 0.16),
            splashColor:
            AppColors.error.withValues(alpha: 0.08),
            highlightColor:
            AppColors.error.withValues(alpha: 0.04),
            backgroundColor: isDark1 ? AppColors.darkCard : AppColors.lightCard,
            borderColor: isDark1 ? AppColors.darkBorder : AppColors.lightBorder,

            onTap: () {
              _selectMethod(RecoveryMethod.sms);
            },
          ),
          SizedBox(height: 10.h),
          ActionMenuTile(
            title: 'Verify with 2FA',
            icon: Iconsax.key,
            iconColor: AppColors.containerColor,
            iconBackgroundColor:
            AppColors.containerColor.withValues(
              alpha: 0.16,
            ),
            splashColor:
            AppColors.containerColor.withValues(
              alpha: 0.08,
            ),
            highlightColor:
            AppColors.containerColor.withValues(
              alpha: 0.04,
            ),
            backgroundColor: isDark1 ? AppColors.darkCard : AppColors.lightCard,            borderColor: isDark1 ? AppColors.darkBorder : AppColors.lightBorder,
            onTap: () {
              _selectMethod(RecoveryMethod.twoFactor);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputStep(
      BuildContext context,
      bool isDark,
      ) {
    final TextTheme textTheme =
        Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (
          BuildContext context,
          BoxConstraints constraints,
          ) {
        return SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? 24.h
                : 32.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 16.h),
                    Image.asset(
                      _selectedMethodImage,
                      width: 180.w,
                      height: 180.w,
                      fit: BoxFit.contain,
                      errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                          ) {
                        return Container(
                          width: 130.w,
                          height: 130.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedMethodColor
                                .withValues(alpha: 0.10),
                          ),
                          child: Icon(
                            _fieldIcon,
                            size: 54.sp,
                            color: _selectedMethodColor,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      _inputDescription,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    TextFormField(
                      controller: _inputController,
                      focusNode: _inputFocusNode,
                      keyboardType: _keyboardType,
                      textInputAction: TextInputAction.done,
                      inputFormatters: _inputFormatters,
                      autofillHints: _autofillHints,
                      autocorrect: false,
                      enableSuggestions:
                      _selectedMethod ==
                          RecoveryMethod.email,
                      autovalidateMode: _validationEnabled
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      validator: _validateInput,
                      onFieldSubmitted: (_) {
                        _submitRecoveryRequest();
                      },
                      onTapOutside: (
                          PointerDownEvent event,
                          ) {
                        _inputFocusNode.unfocus();
                      },
                      // decoration: InputDecoration(
                      //   hintText: _inputHint,
                      //     prefixIcon: Icon(
                      //       _fieldIcon,
                      //       size: 20.sp,
                      //       color: _selectedMethodColor,
                      //     ),
                      //   //   filled: true,
                      //     fillColor: isDark
                      //         ? AppColors.darkCard
                      //         : AppColors.lightCard,
                      //   filled: true,
                      // ),
                      decoration: InputDecoration(
                        hintText: _inputHint,
                        prefixIcon: Icon(
                          _fieldIcon,
                          size: 20.sp,
                          color: _selectedMethodColor,
                        ),
                        filled: true,
                        fillColor: isDark
                            ? AppColors.darkCard
                            : AppColors.lightCard,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 15.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: _selectedMethodColor,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.error,
                          ),
                        ),
                        focusedErrorBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.error,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : _submitRecoveryRequest,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.success,
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor:
                          AppColors.success.withValues(
                            alpha: 0.55,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                            : Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _submitButtonText,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    _buildHelpText(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessStep(BuildContext context) {
    final TextTheme textTheme =
        Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (
          BuildContext context,
          BoxConstraints constraints,
          ) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 32.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 30.h),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(
                      _selectedMethodImage,
                      width: 190.w,
                      height: 190.w,
                      fit: BoxFit.contain,
                      errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                          ) {
                        return Container(
                          width: 140.w,
                          height: 140.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedMethodColor
                                .withValues(alpha: 0.10),
                          ),
                          child: Icon(
                            _fieldIcon,
                            size: 60.sp,
                            color: _selectedMethodColor,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 14.w,
                      bottom: 18.h,
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.check_mark,
                          size: 18.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  _successTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  _successDescription,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 26.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _handleSuccessButton,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _successButtonText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          _selectedMethod ==
                              RecoveryMethod.email
                              ? CupertinoIcons.mail
                              : CupertinoIcons.arrow_right,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                _buildHelpText(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHelpText(BuildContext context) {
    final TextTheme textTheme =
        Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(
          "Can't access your recovery details?",
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
        SizedBox(height: 3.h),
        Text.rich(
          TextSpan(
            text: 'Contact support at ',
            style: textTheme.bodySmall,
            children: <InlineSpan>[
              TextSpan(
                text: 'help@nightingale.ai',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:med_pilot_ai/core/constants/app_colors.dart';
// import 'package:med_pilot_ai/core/theme/system_ui_overlay.dart';
// import 'package:med_pilot_ai/core/widgets/custom_app_bar_widget.dart';
// import 'package:med_pilot_ai/presentation/authentication_screens/forget_password_screen/widget/action_menu_tile.dart';
//
// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }
//
// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textTheme = Theme.of(context).textTheme;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: AppSystemUiOverlay.style(context),
//       child: Scaffold(
//         backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
//         appBar: CustomAppBarWidget(
//           showBackButton: true,
//           backgroundColor:
//           isDark ? AppColors.darkBackground : AppColors.lightBackground,
//           foregroundColor:
//           isDark ? AppColors.lightBackground : AppColors.darkBackground,
//         ),
//
//         body: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20.h,),
//               Text(
//                 "Forget Password",
//                 style: textTheme.titleLarge,
//               ),
//               SizedBox(height: 10.h,),
//               Text(
//                 "Please select the following options to reset your password.",
//                 style: textTheme.bodyMedium,
//               ),
//               SizedBox(height: 20.h,),
//
//               ActionMenuTile(
//                 title: 'Send via Email',
//                 // subtitle: 'Send this report directly to an email address',
//                 icon: CupertinoIcons.mail,
//                 iconColor: AppColors.success,
//                 onTap: () {
//                   // Open email screen or email bottom sheet
//                 },
//               ),
//               SizedBox(height: 10.h,),
//               ActionMenuTile(
//                 title: 'Send via SMS',
//                 // subtitle: 'Send this report directly to an email address',
//                 icon: CupertinoIcons.device_phone_portrait,
//                 iconColor: AppColors.error,
//                 iconBackgroundColor: AppColors.error.withValues(alpha: 0.40),
//                 splashColor: AppColors.error.withValues(alpha: 0.08),
//                 highlightColor: AppColors.error.withValues(alpha: 0.04),
//                 onTap: () {
//                   // Open email screen or email bottom sheet
//                 },
//               ),
//               SizedBox(height: 10.h,),
//               ActionMenuTile(
//                 title: 'Send via 2FA',
//                 // subtitle: 'Send this report directly to an email address',
//                 icon: Iconsax.key,
//                 iconColor: AppColors.containerColor,
//                 iconBackgroundColor: AppColors.containerColor.withValues(alpha: 0.40),
//                 splashColor: AppColors.containerColor.withValues(alpha: 0.08),
//                 highlightColor: AppColors.containerColor.withValues(alpha: 0.04),
//                 onTap: () {
//                   // Open email screen or email bottom sheet
//                 },
//               ),
//               // Container(
//               //   width: double.infinity,
//               //   padding: EdgeInsets.all(10.sp),
//               //   decoration: BoxDecoration(
//               //     color: AppColors.white,
//               //     border: Border.all(
//               //       color: AppColors.borderColor,
//               //       width: 1,
//               //     ),
//               //     borderRadius: BorderRadius.circular(10)
//               //   ),
//               //   child: Row(
//               //     children: [
//               //       Container(
//               //         width: 50.w,
//               //         height: 50.h,
//               //         decoration: BoxDecoration(
//               //           color: AppColors.success.withValues(alpha: 0.30),
//               //           shape: BoxShape.circle,
//               //           border: Border.all(
//               //               color: AppColors.success.withValues(alpha: 0.60),
//               //           ),
//               //         ),
//               //         child: Icon(
//               //           CupertinoIcons.mail,
//               //           color: AppColors.success.withValues(alpha: 0.60),
//               //         ),
//               //       ),
//               //       SizedBox(width: 10.w,),
//               //       Text(
//               //         "Send via Email",
//               //         style: textTheme.bodyLarge?.copyWith(
//               //           fontSize: 14,
//               //           fontWeight: FontWeight.w700,
//               //         ),
//               //       ),
//               //       Spacer(),
//               //       Icon(
//               //         CupertinoIcons.right_chevron,
//               //       )
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
