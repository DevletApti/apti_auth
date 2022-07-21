import 'package:apti_mobile/cubit/send_email_state.dart';
import 'package:apti_mobile/model/send_email_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../service/IRegisterService.dart';

class SendEmailCubit extends Cubit<SendEmailState> {
  final GlobalKey<FormState> formKey;
  final IRegisterService service;
  bool isLoginFail = false;
  bool isLoading = false;
  bool isComplete = false;

  SendEmailCubit(this.formKey, {required this.service})
      : super(SendInitial());

  Future<void> sendEmail({required String email}) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.sendEmail(email: email);
      changeLoadingView();
      if (data is SendEmailVerificationCode) {
        isComplete = true;
        emit(SendComplete(isComplete));
      }
    } else {
      isLoginFail = true;
      emit(SendValidateState(isLoginFail));
    }
  }
// vorobeyj@yahoo.com
// Flutter_1234

// pokimon.taylor@yahoo.com
// Ataballyyev98765
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(SendLoadingState(isLoading));
  }
}


