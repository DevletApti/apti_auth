class ForgotPasswordRequestModel {
  int? userId;
  String? resetCode;
  String? password;
  String? returnUrl;
  String? singleSignIn;
  String? c;

  ForgotPasswordRequestModel(
      {this.userId,
      this.resetCode,
      this.password,
      this.returnUrl,
      this.singleSignIn,
      this.c});

  ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    resetCode = json['resetCode'];
    password = json['password'];
    returnUrl = json['returnUrl'];
    singleSignIn = json['singleSignIn'];
    c = json['c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['resetCode'] = resetCode;
    data['password'] = password;
    data['returnUrl'] = returnUrl;
    data['singleSignIn'] = singleSignIn;
    data['c'] = c;
    return data;
  }
}
