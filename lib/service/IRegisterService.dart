import 'package:apti_mobile/model/send_email_response_model.dart';
import 'package:apti_mobile/model/verify_email_response_model.dart';
import 'package:dio/dio.dart';

import '../model/register_response_model.dart';

abstract class IRegisterService {
  final Dio dio;

  IRegisterService(this.dio);

  final String registerPath = IRegisterServicePath.REGISTER.rawValue;
  final String sendPath = IRegisterServicePath.SENDEMAIL.rawValue;
  final String verifyPath = IRegisterServicePath.VERIFYEMAIL.rawValue;

  Future<RegisterResponseModel?> userRegister({
    required String name,
    required String surname,
    required String emailAddress,
    required String password,
    required String phoneNumber,
  });
  Future<SendEmailVerificationCode?> sendEmail({required String email});
  Future<VerifyEmailVerificationCode?> verifyEmail(
      {required String attemptId, required String code});
}

enum IRegisterServicePath {
  REGISTER,
  SENDEMAIL,
  VERIFYEMAIL,
}

extension ILoginServicePathExtension on IRegisterServicePath {
  String get rawValue {
    switch (this) {
      case IRegisterServicePath.REGISTER:
        return '/api/services/app/Account/RegisterFromMobile';
      case IRegisterServicePath.SENDEMAIL:
        return '/api/services/app/EmailVerifications/SendEmailVerificationCode';
      case IRegisterServicePath.VERIFYEMAIL:
        return '/api/services/app/EmailVerifications/VerifyEmailVerificationCode';
    }
  }
}
