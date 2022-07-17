import 'package:Apti/model/forgot_password_request.dart';
import 'package:Apti/model/forgot_passworfd_response.dart';
import 'package:Apti/model/send_email_response_model.dart';
import 'package:Apti/model/verify_email_response_model.dart';
import 'package:dio/dio.dart';

import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

abstract class IForgotPasswordService {
  final Dio dio;

  IForgotPasswordService(this.dio);

  Future<ForgotPasswordResponseModel?> forgotPassword(ForgotPasswordRequestModel model);
  Future<SendEmailVerificationCode?> sendEmail({required String email});
  Future<VerifyEmailVerificationCode?> verifyEmail(
      {required String attemptId, required String code});
}

enum IRegisterServicePath { UPDATEPASSWORD }

extension ILoginServicePathExtension on IRegisterServicePath {
  String get rawValue {
    switch (this) {
      case IRegisterServicePath.UPDATEPASSWORD:
        return '/api/services/app/EmailVerifications/VerifyEmailVerificationCode';
    }
  }
}
