import 'package:go_router/go_router.dart';
import 'package:med_pilot_ai/core/router/app_routes.dart';
import 'package:med_pilot_ai/presentation/authentication_screens/forget_password_screen/forget_password_screen.dart';
import 'package:med_pilot_ai/presentation/authentication_screens/login_screen/login_screen.dart';
import 'package:med_pilot_ai/presentation/authentication_screens/sign_up_screen/sign_up_screen.dart';
import 'package:med_pilot_ai/presentation/dashboard_screens/dashboard_screen.dart';
import 'package:med_pilot_ai/presentation/health_assessment_screen/health_assessment_screen.dart';
import 'package:med_pilot_ai/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:med_pilot_ai/presentation/root_screen.dart';
import 'package:med_pilot_ai/presentation/splash_screen/splash_screen.dart';
import 'package:med_pilot_ai/presentation/welcome/welcome_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.welcomeScreen,
        builder: (context, state) => const WelcomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoutes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: AppRoutes.forgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),

      GoRoute(
        path: AppRoutes.healthAssessmentScreen,
        builder: (context, state) => const HealthAssessmentScreen(),
      ),

      GoRoute(
        path: AppRoutes.rootScreen,
        builder: (context, state) => const RootScreen(),
      ),

      GoRoute(
        path: AppRoutes.dashboardScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}