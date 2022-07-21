class ResetPasswordModel {
  bool? canLogin;
  String? userName;

  ResetPasswordModel({this.canLogin, this.userName});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    canLogin = json['canLogin'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['canLogin'] = canLogin;
    data['userName'] = userName;
    return data;
  }
}
