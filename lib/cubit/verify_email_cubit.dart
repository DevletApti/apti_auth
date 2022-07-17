// import 'package:Apti/core/end_points/end_points.dart';
// import 'package:Apti/cubit/verify_email_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:Apti/service/dio_helper.dart';

// class VerifyEmailCubit extends Cubit<VerifyEmailStates> {
//   // final TextEditingController nameController;
//   // final TextEditingController surnameController;
//   // final TextEditingController emailController;
//   // final TextEditingController passwordController;
//   // final TextEditingController phoneController;

//   // final GlobalKey<FormState> formKey;
//   VerifyEmailCubit() : super(VerifyEmailInitialState());
//   static VerifyEmailCubit get(context) => BlocProvider.of(context);
//   DioHelper func = DioHelper();
//   sendEmail({
//     String? attemptId,
//     String? code,
//   }) {
//     emit(VerifyEmailLoadingState());
//     func.getData(
//       url: VERIFY_EMAIL,
//       queryParameters: {'attemptId': attemptId, 'code': code},
//     ).then(
//       (value) {
//         emit(
//           VerifyEmailSuccessState(),
//         );
//       },
//     ).catchError((error) {
//       print(error.toString());
//       emit(
//         VerifyEmailErrorState(
//           error: error.toString(),
//         ),
//       );
//     });
//   }
// }


import 'package:Apti/cubit/verify_email_state.dart';
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