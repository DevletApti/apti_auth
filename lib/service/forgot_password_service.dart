import 'dart:io';

import 'package:apti_mobile/model/reset_password_model.dart';
import 'package:apti_mobile/service/IForgotPasswordService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordService extends IForgotPasswordService {
  ForgotPasswordService(Dio dio) : super(dio);

  void saveBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  @override
  Future<bool> resetPasswd(
      {required String password, required String c}) async {
    Map<String, dynamic> reqData = {
      "password": password,
      "c": c,
    };
    ResetPasswordModel data;
    dio.options.headers['Abp.TenantId'] = 1;
    var response = await dio.post(resetPasswordUrl,
        data: reqData, options: Options(validateStatus: (status) => true));

    if (response.statusCode == HttpStatus.ok) {
      data = ResetPasswordModel.fromJson(response.data);
      debugPrint("${data.userName} from service");
      return data.canLogin!;
    } else {
      debugPrint("${response.statusCode} from service");
      return false;
    }
  }

  @override
  Future<bool> sendPasswdResetCode(
      {required String emailAddress, required int applicationType}) async {
    Map<String, dynamic> reqData = {
      "emailAddress": emailAddress,
      "applicationType": applicationType,
    };
    dio.options.headers['Abp.TenantId'] = 1;
    var response = await dio.post(sendPasswordCodeUrl,
        data: reqData, options: Options(validateStatus: (status) => true));

    if (response.statusCode == HttpStatus.ok) {
      debugPrint("${response.statusCode} from service");
      return true;
    } else {
      debugPrint("${response.statusCode} from service");
      return false;
    }
  }
}
