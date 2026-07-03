import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/constants/app_images.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _keepSignedIn = true;

  static const Color _primaryColor = Color(0xFF14B8A6);
  static const Color _darkColor = Color(0xFF1D2939);
  static const Color _secondaryTextColor = Color(0xFF667085);
  static const Color _borderColor = Color(0xFFD0D5DD);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() != true) {
      return;
    }

    // Login API call yahan karein.
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 44.h),

                          // Nightingale logo
                          Image.asset(
                            AppImages.appLogo,
                            width: 37.w,
                            height: 37.w,
                            fit: BoxFit.contain,
                            errorBuilder: (
                                context,
                                error,
                                stackTrace,
                                ) {
                              return Icon(
                                Icons.local_hospital_outlined,
                                size: 37.sp,
                                color: _primaryColor,
                              );
                            },
                          ),

                          SizedBox(height: 6.h),

                          Text(
                            'nightingale',
                            style: TextStyle(
                              color: _darkColor,
                              fontSize: 20.sp,
                              height: 1,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1.1.w,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            'Sign In to access smart medical & e-pharma.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _secondaryTextColor,
                              fontSize: 13.sp,
                              height: 1.35,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          SizedBox(height: 49.h),

                          _FieldLabel(
                            label: 'Email Address',
                          ),

                          SizedBox(height: 7.h),

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: _primaryColor,
                            style: TextStyle(
                              color: _darkColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: _inputDecoration(
                              hintText:
                              'Enter your email address...',
                              prefixIcon:
                              Icons.mail_outline_rounded,
                            ),
                            validator: (value) {
                              final email = value?.trim() ?? '';

                              if (email.isEmpty) {
                                return 'Please enter your email address';
                              }

                              if (!RegExp(
                                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                              ).hasMatch(email)) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          _FieldLabel(
                            label: 'Password',
                          ),

                          SizedBox(height: 7.h),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            keyboardType:
                            TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            cursorColor: _primaryColor,
                            onFieldSubmitted: (_) => _signIn(),
                            style: TextStyle(
                              color: _darkColor,
                              fontSize: 13.sp,
                              letterSpacing: 1,
                            ),
                            decoration: _inputDecoration(
                              hintText: '****************',
                              prefixIcon:
                              Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                splashRadius: 20.r,
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                    !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons
                                      .visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18.sp,
                                  color:
                                  const Color(0xFF98A2B3),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Please enter your password';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    _keepSignedIn =
                                    !_keepSignedIn;
                                  });
                                },
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 180,
                                      ),
                                      width: 18.w,
                                      height: 18.w,
                                      decoration: BoxDecoration(
                                        color: _keepSignedIn
                                            ? _primaryColor
                                            : Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(
                                          3.r,
                                        ),
                                        border: Border.all(
                                          color: _keepSignedIn
                                              ? _primaryColor
                                              : _borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: _keepSignedIn
                                          ? Icon(
                                        Icons.check_rounded,
                                        size: 14.sp,
                                        color: Colors.white,
                                      )
                                          : null,
                                    ),
                                    SizedBox(width: 7.w),
                                    Text(
                                      'Keep me signed in',
                                      style: TextStyle(
                                        color: _darkColor,
                                        fontSize: 12.5.sp,
                                        fontWeight:
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),

                              GestureDetector(
                                onTap: () {
                                  // Forgot password screen.
                                  context.go(AppRoutes.forgetPasswordScreen);
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: _primaryColor,
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          SizedBox(
                            width: double.infinity,
                            height: 47.h,
                            child: ElevatedButton(
                              onPressed: _signIn,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: _primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
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
                          ),

                          SizedBox(height: 18.h),

                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFE4E7EC),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                ),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: _secondaryTextColor,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFE4E7EC),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),

                          SizedBox(
                            width: double.infinity,
                            height: 47.h,
                            child: ElevatedButton(
                              onPressed: () {
                                // Google sign-in yahan call karein.
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: _darkColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(24.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CustomPaint(
                                      painter:
                                      _GoogleLogoPainter(),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Sign In With Google',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),

                          Padding(
                            padding: EdgeInsets.only(
                              top: 30.h,
                              bottom: 28.h,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Sign-up screen open karein.
                                context.go(AppRoutes.signUpScreen);
                              },
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: _secondaryTextColor,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text:
                                      "Don't have an account? ",
                                    ),
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: _primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
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
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: const Color(0xFF667085),
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(
        prefixIcon,
        size: 18.sp,
        color: const Color(0xFF667085),
      ),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 14.h,
      ),
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 2,
      errorStyle: TextStyle(
        fontSize: 10.sp,
        height: 1,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: const BorderSide(
          color: _borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: const BorderSide(
          color: _primaryColor,
          width: 1.3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.r),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.3,
        ),
      ),
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF1D2939),
          fontSize: 12.5.sp,
          height: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.19;

    final Rect arcRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    Paint paint(Color color) {
      return Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
    }

    canvas.drawArc(
      arcRect,
      -0.65,
      1.60,
      false,
      paint(const Color(0xFF4285F4)),
    );

    canvas.drawArc(
      arcRect,
      0.95,
      1.10,
      false,
      paint(const Color(0xFF34A853)),
    );

    canvas.drawArc(
      arcRect,
      2.05,
      0.72,
      false,
      paint(const Color(0xFFFBBC05)),
    );

    canvas.drawArc(
      arcRect,
      2.77,
      1.40,
      false,
      paint(const Color(0xFFEA4335)),
    );

    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(
      Offset(size.width * 0.52, size.height * 0.52),
      Offset(size.width * 0.94, size.height * 0.52),
      bluePaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.88, size.height * 0.50),
      Offset(size.width * 0.88, size.height * 0.72),
      bluePaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}