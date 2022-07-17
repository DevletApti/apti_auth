class RegisterRequestModel {
  String? name;
  String? surname;
  String? emailAddress;
  String? password;
  String? phoneNumber;

  RegisterRequestModel(
      {this.name,
      this.surname,
      this.emailAddress,
      this.password,
      this.phoneNumber});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['emailAddress'] = emailAddress;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
