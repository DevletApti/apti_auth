class LoginResponseModel {
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? shouldResetPassword;
  String? passwordResetCode;
  int? userId;
  bool? requiresTwoFactorVerification;
  List<TwoFactorAuthProviders>? twoFactorAuthProviders;
  String? twoFactorRememberClientToken;
  String? returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  LoginResponseModel(
      {this.accessToken,
      this.encryptedAccessToken,
      this.expireInSeconds,
      this.shouldResetPassword,
      this.passwordResetCode,
      this.userId,
      this.requiresTwoFactorVerification,
      this.twoFactorAuthProviders,
      this.twoFactorRememberClientToken,
      this.returnUrl,
      this.refreshToken,
      this.refreshTokenExpireInSeconds});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    encryptedAccessToken = json['encryptedAccessToken'];
    expireInSeconds = json['expireInSeconds'];
    shouldResetPassword = json['shouldResetPassword'];
    passwordResetCode = json['passwordResetCode'];
    userId = json['userId'];
    requiresTwoFactorVerification = json['requiresTwoFactorVerification'];
    if (json['twoFactorAuthProviders'] != null) {
      twoFactorAuthProviders = <TwoFactorAuthProviders>[];
      json['twoFactorAuthProviders'].forEach((v) {
        twoFactorAuthProviders!.add(new TwoFactorAuthProviders.fromJson(v));
      });
    }
    twoFactorRememberClientToken = json['twoFactorRememberClientToken'];
    returnUrl = json['returnUrl'];
    refreshToken = json['refreshToken'];
    refreshTokenExpireInSeconds = json['refreshTokenExpireInSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['encryptedAccessToken'] = this.encryptedAccessToken;
    data['expireInSeconds'] = this.expireInSeconds;
    data['shouldResetPassword'] = this.shouldResetPassword;
    data['passwordResetCode'] = this.passwordResetCode;
    data['userId'] = this.userId;
    data['requiresTwoFactorVerification'] = this.requiresTwoFactorVerification;
    if (this.twoFactorAuthProviders != null) {
      data['twoFactorAuthProviders'] =
          this.twoFactorAuthProviders!.map((v) => v.toJson()).toList();
    }
    data['twoFactorRememberClientToken'] = this.twoFactorRememberClientToken;
    data['returnUrl'] = this.returnUrl;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpireInSeconds'] = this.refreshTokenExpireInSeconds;
    return data;
  }
}

class TwoFactorAuthProviders {
  String? value;

  TwoFactorAuthProviders({this.value});

  TwoFactorAuthProviders.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}