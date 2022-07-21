import 'package:dio/dio.dart';

import '../core/navigation/constants/api_constants.dart';
import '../model/login_response_model.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);

  final String loginPath = ILoginServicePath.LOGIN.rawValue;

  Future<LoginResponseModel?> userLogin({required String emailAddress, required String password});
}

enum ILoginServicePath { LOGIN }

extension ILoginServicePathExtension on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.LOGIN:
        return '/api/TokenAuth/Authenticate';
    }
  }
}
