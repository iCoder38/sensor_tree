class ApiPayloads {
  // ========================= CHECK USER ======================================
  static Map<String, dynamic> CheckUserPayload(String userId) {
    return {'userId': userId};
  }

  // login
  static Map<String, dynamic> payloadLogin(String email, String password) {
    return {'email': email, 'password': password};
  }

  // registration
  static Map<String, dynamic> payloadRegistration(
    String firstname,
    String lastname,
    String email,
    String password,
    String mobile,
  ) {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'mobile': mobile,
    };
  }
}
