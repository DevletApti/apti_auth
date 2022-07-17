// class LoginRequestModel {
//   String? userNameOrEmailAddress;
//   String? password;

//   LoginRequestModel({this.userNameOrEmailAddress, this.password});

//   LoginRequestModel.fromJson(Map<String, dynamic> json) {
//     userNameOrEmailAddress = json['userNameOrEmailAddress'];
//     password = json['password'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userNameOrEmailAddress'] = this.userNameOrEmailAddress;
//     data['password'] = this.password;
//     return data;
//   }
// }

class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}