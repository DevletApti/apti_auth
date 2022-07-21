import 'package:apti_mobile/model/send_email_response_model.dart';
import 'package:apti_mobile/model/verify_email_response_model.dart';

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
