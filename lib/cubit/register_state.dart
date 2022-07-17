import '../model/login_response_model.dart';
import '../model/register_response_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterComplete extends RegisterState {
  final bool isComplete;

  RegisterComplete(this.isComplete);
}

class RegisterValidateState extends RegisterState {
  final bool isValidate;
  RegisterValidateState(this.isValidate);
}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;
  RegisterLoadingState(this.isLoading);
}
