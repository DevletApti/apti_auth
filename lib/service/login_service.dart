import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response_model.dart';

import 'ILoginService.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  void saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  Future<LoginResponseModel?> userLogin(
      {required String emailAddress, required String password}) async {
    Map<String, dynamic> reqData = {
      "userNameOrEmailAddress": emailAddress,
      "password": password,
    };
    LoginResponseModel data;
    dio.options.headers['Abp.TenantId'] = 1;
    var response = await dio.post(loginPath,
        data: reqData, options: Options(validateStatus: (status) => true));

    if (response.statusCode == HttpStatus.ok) {
      data = LoginResponseModel.fromJson(response.data);
      saveString("accessToken", data.result!.accessToken!);
      saveString("refreshToken", data.result!.refreshToken!);
      return data;
    } else {
      debugPrint("${response.statusCode}");
      return null;
    }
  }
}
