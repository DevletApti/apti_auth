import 'package:apti_mobile/cubit/verify_email_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/verify_email_response_model.dart';
import '../service/IRegisterService.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
final GlobalKey<FormState> formKey;
final IRegisterService service;
bool isLoginFail = false;
bool isLoading = false;
bool isComplete = false;

  VerifyEmailCubit(this.formKey, {required this.service}) : super(VerifyInitial());

  

  Future<void> verifyEmail({required String attemptId, required String code}) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.verifyEmail(attemptId: attemptId, code: code);
      changeLoadingView();
      if (data is VerifyEmailVerificationCode) {
        isComplete = true;
        emit(VerifyComplete(isComplete));
      }
    } else {
      isLoginFail = true;
      emit(VerifyValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(VerifyLoadingState(isLoading));
  }
}