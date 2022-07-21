import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/login_response_model.dart';
import '../service/ILoginService.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey;

  final ILoginService service;
  bool isLoginFail = false;
  bool isLoading = false;
  bool isComplete = false;

  LoginCubit(
    this.formKey, {
    required this.service,
  }) : super(LoginInitial());

  Future<void> login(
      {required String emailAddress, required String password}) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.userLogin(
          emailAddress: emailAddress, password: password);
      changeLoadingView();
      if (data is LoginResponseModel) {
        isComplete = true;
        emit(LoginComplete(isComplete));
      }
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = isLoading;
    emit(LoginLoadingState(isLoading));
  }
}
