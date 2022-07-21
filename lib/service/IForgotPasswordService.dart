import 'package:apti_mobile/model/reset_password_model.dart';
import 'package:dio/dio.dart';

abstract class IForgotPasswordService {
  final Dio dio;

  IForgotPasswordService(this.dio);

  final String sendPasswordCodeUrl =
      IForgotPasswordServicePath.SEND_PASSWORD_CODE.rawValue;
  final String resetPasswordUrl =
      IForgotPasswordServicePath.RESET_PASSWORD.rawValue;

  Future<bool> sendPasswdResetCode(
      {required String emailAddress, required int applicationType});
  Future<bool?> resetPasswd(
      {required String password, required String c});
// intent://site.test.apti.us/#Intent;     scheme=https;   package=com.apti.apti_mobile;    action={action};     tenantId={tenantId ?? 0};    end

}

enum IForgotPasswordServicePath { SEND_PASSWORD_CODE, RESET_PASSWORD }

extension ILoginServicePathExtension on IForgotPasswordServicePath {
  String get rawValue {
    switch (this) {
      case IForgotPasswordServicePath.SEND_PASSWORD_CODE:
        return '/api/services/app/Account/SendPasswordResetCode';
      case IForgotPasswordServicePath.RESET_PASSWORD:
        return '/api/services/app/Account/ResetPassword';
    }
  }
}
