import 'package:flutter/material.dart';

class LoginFormController {
  // Controllers
  final TextEditingController contEmail = TextEditingController();
  final TextEditingController contPassword = TextEditingController();

  // email
  String? validateEmail(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Email cannot be empty.";
    }

    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    if (!RegExp(emailPattern).hasMatch(value)) {
      return "Enter a valid email address.";
    }

    return null;
  }

  // validate password
  String? validatePassword(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Password cannot be empty.";
    }
    return null;
  }

  // Dispose method to clean up resources
  void dispose() {
    contEmail.dispose();
    contPassword.dispose();
  }
}
