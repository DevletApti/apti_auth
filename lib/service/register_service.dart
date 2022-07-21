import 'dart:io';

import 'package:apti_mobile/model/send_email_response_model.dart';
import 'package:apti_mobile/model/verify_email_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    dio.options.headers['Abp.TenantId'] = 1;
    var response = await dio.post(
      registerPath,
      data: reqData, options: Options(validateStatus: (status) => true)
    );

    if (response.statusCode == HttpStatus.ok) {
      data = RegisterResponseModel.fromJson(response.data);
      saveBool("can-login", data.result!.canLogin!);
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<SendEmailVerificationCode?> sendEmail({required String email}) async {
    Map<String, dynamic> emailData = {"email": email};

    SendEmailVerificationCode data;

    var response = await dio.post(
      sendPath,
      data: emailData, options: Options(validateStatus: (status) => true)
    );

    if (response.statusCode == HttpStatus.ok) {
      data = SendEmailVerificationCode.fromJson(response.data);
      saveString("attemptId", data.result!);
      saveString("emailAddress", email);
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<VerifyEmailVerificationCode?> verifyEmail(
      {required String attemptId, required String code}) async {
    Map<String, dynamic> verifyData = {"attemptId": attemptId, "code": code};

    VerifyEmailVerificationCode data;

    var response = await dio.post(verifyPath,
        data: verifyData, options: Options(validateStatus: (status) => true));

    if (response.statusCode == HttpStatus.ok) {
      data = VerifyEmailVerificationCode.fromJson(response.data);
      saveBool("verify-email", data.result!);
      return data;
    } else {
      return null;
    }
  }
}











