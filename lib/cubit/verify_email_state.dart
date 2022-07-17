// abstract class VerifyEmailStates {}

// class VerifyEmailInitialState extends VerifyEmailStates {}

// class VerifyEmailLoadingState extends VerifyEmailStates {}

// class VerifyEmailSuccessState extends VerifyEmailStates {
 

//  VerifyEmailSuccessState();
// }

// class VerifyEmailErrorState extends VerifyEmailStates {
//   final String? error;

//   VerifyEmailErrorState({this.error});
// }













import 'package:Apti/model/send_email_response_model.dart';
import 'package:Apti/model/verify_email_response_model.dart';

import '../model/register_response_model.dart';

abstract class VerifyEmailState {}

class VerifyInitial extends VerifyEmailState {}

class VerifyComplete extends VerifyEmailState {
  final bool isComplete;

  VerifyComplete(this.isComplete);
}

class VerifyValidateState extends VerifyEmailState {
  final bool isValidate;

  VerifyValidateState(this.isValidate);
}

class VerifyLoadingState extends VerifyEmailState {
  final bool isLoading;

  VerifyLoadingState(this.isLoading);
}
