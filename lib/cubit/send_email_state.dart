// abstract class SendEmailStates {}

// class SendEmailInitialState extends SendEmailStates {}

// class SendEmailLoadingState extends SendEmailStates {}

// class SendEmailSuccessState extends SendEmailStates {
 

//  SendEmailSuccessState();
// }

// class SendEmailErrorState extends SendEmailStates {
//   final String? error;

//   SendEmailErrorState({this.error});
// }














import 'package:Apti/model/send_email_response_model.dart';

import '../model/register_response_model.dart';

abstract class SendEmailState {}

class SendInitial extends SendEmailState {}

class SendComplete extends SendEmailState {
final bool isComplete;

  SendComplete(this.isComplete);
}

class SendValidateState extends SendEmailState {
  final bool isValidate;

  SendValidateState(this.isValidate);
}

class SendLoadingState extends SendEmailState {
  final bool isLoading;

  SendLoadingState(this.isLoading);
}
