// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../core/end_points/end_points.dart';
// import '../model/login_response_model.dart';
// import '../service/dio_helper.dart';
// import 'login_state.dart';

// class LoginCubit extends Cubit<LoginStates> {
//   LoginCubit() : super(LoginInitialState());

//   static LoginCubit get(context) => BlocProvider.of(context);

//   LoginResponseModel? loginModel;
//   DioHelper func = DioHelper();
//   void userLogin({
//     @required String? userNameOrEmailAddress,
//     @required String? password,
//   }) {
//     emit(LoginLoadingState());
//     func.postData(
//       url: LOGIN,
//       data: {
//         'userNameOrEmailAddress': userNameOrEmailAddress,
//         'password': password,
//       },
//     ).then((value) {
//       print(value);
//       loginModel = LoginResponseModel.fromJson(value.data);
//       emit(
//         LoginSuccessState(loginModel),
//       );
//     }).catchError((error) {
//       print(error.toString());
//       emit(
//         LoginErrorState(
//           error: error.toString(),
//         ),
//       );
//     });
//   }

//   IconData suffix = Icons.visibility_outlined;
//   bool isPassword = true;

//   void changePasswordVisibility() {
//     isPassword = !isPassword;
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

//     emit(LoginChangePasswordVisibilityState());
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/login_request_model.dart';
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
