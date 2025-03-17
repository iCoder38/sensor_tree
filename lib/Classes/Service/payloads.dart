class ApiPayloads {
  // ========================= CHECK USER ======================================
  static Map<String, dynamic> CheckUserPayload(String userId) {
    return {'userId': userId};
  }

  // login
  static Map<String, dynamic> payloadLogin(String email, String password) {
    return {'email': email, 'password': password};
  }

  // forgot password
  static Map<String, dynamic> payloadForgotPassword(String email) {
    return {'email': email};
  }

  // otp
  static Map<String, dynamic> payloadOTP(
    String otp,
    String email,
    String password,
  ) {
    return {'otp': otp, 'email': email, 'password': password};
  }

  // registration
  static Map<String, dynamic> payloadRegistration(
    String firstname,
    String lastname,
    String email,
    String password,
    String password_confirmation,
    String mobile,
  ) {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'mobile': mobile,
    };
  }

  // send OTP via reg
  static Map<String, dynamic> payloadSendRegsitrationOTP(
    String name,
    String email,
  ) {
    return {'name': name, 'email': email};
  }

  // verify OTP via reg
  static Map<String, dynamic> payloadVerifyRegistration(String email) {
    return {'email': email};
  }
}
