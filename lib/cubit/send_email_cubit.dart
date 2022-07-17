// import 'package:Apti/core/end_points/end_points.dart';
// import 'package:Apti/cubit/send_email_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:Apti/service/dio_helper.dart';

// class SendEmailCubit extends Cubit<SendEmailStates> {
  // final TextEditingController nameController;
  // final TextEditingController surnameController;
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  // final TextEditingController phoneController;

  // final GlobalKey<FormState> formKey;
//   SendEmailCubit() : super(SendEmailInitialState());
//   static SendEmailCubit get(context) =>
//       BlocProvider.of<SendEmailCubit>(context);
//   DioHelper func = DioHelper();

//   sendEmail({
//     String? email,
//   }) {
//     emit(SendEmailLoadingState());
//     func.postData(
//       url: SEND_EMAIL,
//       data: {
//         'email': email,
//       },
//     ).then(
//       (value) {
//         emit(
//           SendEmailSuccessState(),
//         );
//       },
//     ).catchError((error) {
//       print(error.toString());
//       emit(
//         SendEmailErrorState(
//           error: error.toString(),
//         ),
//       );
//     });
//   }
// }



import 'package:Apti/cubit/send_email_state.dart';
import 'package:Apti/model/send_email_response_model.dart';
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


