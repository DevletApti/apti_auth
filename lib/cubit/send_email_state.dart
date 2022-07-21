import 'package:apti_mobile/model/send_email_response_model.dart';

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
