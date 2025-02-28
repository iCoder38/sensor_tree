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
    if (value.length < 8) {
      return "Password must be at least 8 characters long.";
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return "Password must contain at least one letter.";
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return "Password must contain at least one number.";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character.";
    }

    return null;
  }

  // Dispose method to clean up resources
  void dispose() {
    contEmail.dispose();
    contPassword.dispose();
  }
}
