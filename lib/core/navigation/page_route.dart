import 'package:Apti/view/onboarding_page.dart';
import 'package:flutter/material.dart';

import '../../view/add_new_password_page.dart';
import '../../view/change_password_page.dart';
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
        return MaterialPageRoute(builder: (context) => RegisterPage());
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

      case ChangePasswordPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordPage());
//ForgotPasswordPage
      default:
        return MaterialPageRoute(builder: (context) => const MainPage());
    }
  }
}
//routeName = '/add_new_password';