import 'package:Apti/model/register_response_model.dart';
import 'package:Apti/service/IRegisterService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Apti/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GlobalKey<FormState> formKey;

  final IRegisterService service;
  bool isLoginFail = false;
  bool isLoading = false;
  bool isComplete = false;

  RegisterCubit(
    this.formKey, {
    required this.service,
  }) : super(RegisterInitial());

  Future<void> userRegister({
    required String name,
    required String surname,
    required String emailAddress,
    required String password,
    required String phoneNumber,
  }) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.userRegister(
          name: name,
          surname: surname,
          emailAddress: emailAddress,
          password: password,
          phoneNumber: phoneNumber);
      changeLoadingView();
      if (data is RegisterResponseModel) {
        isComplete = true;
        emit(RegisterComplete(isComplete));
      }
    } else {
      isLoginFail = true;
      emit(RegisterValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = isLoading;
    emit(RegisterLoadingState(isLoading));
  }
}
