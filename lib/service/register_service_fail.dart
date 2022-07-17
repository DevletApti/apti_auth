// import 'dart:io';

// import 'package:Apti/model/verify_email_response_model.dart';
// import 'package:Apti/model/send_email_response_model.dart';
// import 'package:Apti/model/register_response_model.dart';
// import 'package:Apti/model/register_request_model.dart';
// import 'package:Apti/service/IRegisterService.dart';
// import 'package:dio/dio.dart';

// import '../model/login_request_model.dart';
// import '../model/login_response_model.dart';

// import 'ILoginService.dart';

// class RegisterService extends IRegisterService {
//   RegisterService(Dio dio) : super(dio);

//   @override
//   Future<SendEmailVerificationCode?> sendEmail({required String email}) {
//     // TODO: implement sendEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<RegisterResponseModel?> userRegister(RegisterRequestModel model) {
//     // TODO: implement userRegister
//     throw UnimplementedError();
//   }

//   @override
//   Future<VerifyEmailVerificationCode?> verifyEmail({required String attemptId, required String code}) {
//     // TODO: implement verifyEmail
//     throw UnimplementedError();
//   }

//   // @override
//   // Future<LoginResponseModel?> userLogin(LoginRequestModel model) async {
//   //   final response = await dio.post(loginPath, data: model);

//   //   if (response.statusCode == HttpStatus.ok) {
//   //     return LoginResponseModel.fromJson(response.data);
//   //   } else {
//   //     return null;
//   //   }
//   // }
// }
