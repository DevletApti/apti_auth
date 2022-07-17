class ApiConstants {
  static const String baseUrl = 'http://api.test.apti.us';
  static const String authenticate = '$baseUrl/api/TokenAuth/Authenticate';
  static const String registerAuth =
      '$baseUrl/api/services/app/Account/RegisterFromMobile';
  static const String sendEmailVerCode =
      '$baseUrl/api/services/app/EmailVerifications/SendEmailVerificationCode';
  static const String verifyEmailVerCode =
      '$baseUrl/api/services/app/EmailVerifications/VerifyEmailVerificationCode';
}
