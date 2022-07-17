import 'dart:io';

import 'package:Apti/model/send_email_response_model.dart';
import 'package:Apti/model/verify_email_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/register_request_model.dart';

import '../model/register_response_model.dart';
import 'IRegisterService.dart';

class RegisterService extends IRegisterService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RegisterService(Dio dio) : super(dio);

  void saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  void saveBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  @override
  Future<RegisterResponseModel?> userRegister({
    required String name,
    required String surname,
    required String emailAddress,
    required String password,
    required String phoneNumber,
  }) async {
    Map<String, dynamic> reqData = {
      "name": name,
      "surname": surname,
      "emailAddress": emailAddress,
      "password": password,
      "phoneNumber": phoneNumber,
    };

    RegisterResponseModel data;
    dio.options.headers['x-abp-tenantId'] = 'tenantId';
    var response = await dio.post(registerPath,
        data: reqData,);

    if (response.statusCode == HttpStatus.ok) {
      data = RegisterResponseModel.fromJson(response.data);
      saveBool("can-login", data.result!.canLogin!);
      debugPrint(
          "${data.result!.canLogin} this is from service Register service");
      return data;
    } else {
      debugPrint("${response.statusCode}");
      return null;
    }
  }

  @override
  Future<SendEmailVerificationCode?> sendEmail({required String email}) async {
    Map<String, dynamic> emailData = {"email": email};

    SendEmailVerificationCode data;

    var response = await dio.post(
      sendPath,
      data: emailData,
    );

    if (response.statusCode == HttpStatus.ok) {
      data = SendEmailVerificationCode.fromJson(response.data);
      saveString("attemptId", data.result!);
      saveString("emailAddress", email);
      debugPrint("${data.result} this is from service Email Send");
      return data;
    } else {
      debugPrint("${response.statusCode}");
      return null;
    }
  }

  @override
  Future<VerifyEmailVerificationCode?> verifyEmail(
      {required String attemptId, required String code}) async {
    Map<String, dynamic> verifyData = {"attemptId": attemptId, "code": code};

    VerifyEmailVerificationCode data;

    var response = await dio.post(
      verifyPath,
      data: verifyData,
    );

    if (response.statusCode == HttpStatus.ok) {
      data = VerifyEmailVerificationCode.fromJson(response.data);
      saveBool("verify-email", data.result!);
      debugPrint("${data.result} this is from service Email Verify");
      return data;
    } else {
      debugPrint("${response.statusCode}");
      return null;
    }
  }
}






// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class DioHelper {
//   final Dio dio = Dio(
//     BaseOptions(
//         baseUrl: 'http://api.test.apti.us',
//         followRedirects: false,
//         validateStatus: (status) {
//           return status! <= 500;
//         }),
//   );

//   //  Dio dio;

//   // static init() {
//   //   Dio(BaseOptions(
//   //     baseUrl: 'http://api.test.apti.us',
//   //     receiveDataWhenStatusError: true,
//   //   ));
//   // }

//   Future<Response> getData({
//     @required String? url,
//     Map<String, dynamic>? queryParameters,
//     String? lang = 'en',
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Accept': 'application/json, text/plain, */*',
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': "**",
//     };
//     return await dio.get(
//       url!,
//       queryParameters: queryParameters,
//     );
//   }

//   Future<Response> postData({
//     @required String? url,
//     Map<String, dynamic>? queryParameters,
//     @required Map<String, dynamic>? data,
//     String? lang = 'en',
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Accept': 'application/json, text/plain, */*',
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': "**",
//     };
//     return await dio.post(
//       url!,
//       queryParameters: queryParameters,
//       data: data,
//     );
//   }

//   Future<Response> putData({
//     @required String? url,
//     Map<String, dynamic>? queryParameters,
//     @required Map<String, dynamic>? data,
//     String? lang = 'en',
//     String? token,
//     Map<String, String>? date,
//   }) async {
//     dio.options.headers = {
//       'Accept': 'application/json, text/plain, */*',
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': "**",
//     };
//     return await dio.put(
//       url!,
//       queryParameters: queryParameters,
//       data: data,
//     );
//   }
// }









