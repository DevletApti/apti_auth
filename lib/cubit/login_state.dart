
// import '../model/login_response_model.dart';

// abstract class LoginStates {}

// class LoginInitialState extends LoginStates {}

// class LoginLoadingState extends LoginStates {}

// class LoginSuccessState extends LoginStates {
//   final LoginResponseModel? loginModel;

//   LoginSuccessState(this.loginModel);
// }

// class LoginErrorState extends LoginStates {
//   final String? error;

//   LoginErrorState({this.error});
// }

// class LoginChangePasswordVisibilityState extends LoginStates {}

import '../model/login_response_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final bool isComplete;

  LoginComplete(this.isComplete);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}
