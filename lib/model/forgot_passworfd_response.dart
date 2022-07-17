class ForgotPasswordResponseModel {
  bool? canLogin;
  String? userName;

  ForgotPasswordResponseModel({this.canLogin, this.userName});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    canLogin = json['canLogin'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['canLogin'] = canLogin;
    data['userName'] = userName;
    return data;
  }
}
