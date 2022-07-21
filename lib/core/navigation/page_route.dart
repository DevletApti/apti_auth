import 'package:apti_mobile/view/onboarding_page.dart';
import 'package:flutter/material.dart';

import '../../view/add_new_password_page.dart';
import '../../view/change_pass_state_error_page.dart';
import '../../view/change_pass_state_success_page.dart';
import '../../view/email_verify_page.dart';
import '../../view/forget_password_info_page.dart';
import '../../view/forgot_password_page.dart';
import '../../view/login_page.dart';
import '../../view/main_page.dart';
import '../../view/register_page.dart';

class MyPageRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());

      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case EmailVerifyPage.routeName:
        return MaterialPageRoute(builder: (context) => const EmailVerifyPage());
      case ForgotPasswordPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordPage());
      case ForgotPasswordInfoPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordInfoPage());

      case AddNewPasswordPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const AddNewPasswordPage());

      case ChangePassStatePage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ChangePassStatePage());

      case ChangePassSuccessPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ChangePassSuccessPage());
//ForgotPasswordPage
      default:
        return MaterialPageRoute(builder: (context) => const MainPage());
    }
  }
}
//routeName = '/add_new_password';