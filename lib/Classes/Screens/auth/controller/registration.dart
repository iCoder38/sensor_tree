import 'package:flutter/material.dart';

class RegistrationFormController {
  // Controllers
  final TextEditingController contFirstName = TextEditingController();
  final TextEditingController contLastName = TextEditingController();
  final TextEditingController contEmail = TextEditingController();
  final TextEditingController contGender = TextEditingController();
  final TextEditingController contPhoneNumber = TextEditingController();
  final TextEditingController contPhoneNumberCode = TextEditingController();
  final TextEditingController contDOB = TextEditingController();
  final TextEditingController contAddress = TextEditingController();
  final TextEditingController contCountry = TextEditingController();
  final TextEditingController contState = TextEditingController();
  final TextEditingController contCity = TextEditingController();
  final TextEditingController contZipcode = TextEditingController();
  final TextEditingController contPassword = TextEditingController();
  final TextEditingController contConfirmPassword = TextEditingController();

  // First name
  String? validateFirstName(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "First name cannot be empty.";
    }
    if (value.length < 3) {
      return "First name must be at least 3 characters.";
    }
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "First name can only contain alphabets.";
    }
    return null;
  }

  // Last name
  String? validateLastName(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Last name cannot be empty.";
    }
    if (value.length < 3) {
      return "Last name must be at least 3 characters.";
    }
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Last name can only contain alphabets.";
    }
    return null;
  }

  // Last name
  String? validatePhoneNumberCode(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Code cannot be empty.";
    }

    return null;
  }

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

  // phone number
  String? validatePhoneNumber(String value) {
    value = value.trim(); // Remove spaces

    if (value.isEmpty) {
      return "Phone number cannot be empty.";
    }
    if (value.length != 10) {
      // Ensures exactly 10 digits
      return "Phone number must be exactly 10 digits.";
    }
    if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
      // Ensure only numbers
      return "Phone number can only contain digits.";
    }
    return null; // ✅ Valid phone number
  }

  // First name
  String? validateAddress(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Address cannot be empty.";
    }
    if (value.length < 8) {
      return "Address must be at least 8 characters.";
    }
    return null;
  }

  // zipcode
  String? validateZipCode(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "ZIP code cannot be empty.";
    }
    if (value.length != 5) {
      return "ZIP code must be exactly 5 digits.";
    }
    if (!RegExp(r"^[0-9]{5}$").hasMatch(value)) {
      return "ZIP code can only contain digits.";
    }
    return null;
  }

  // validate password
  // Validate password
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
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return "Password must contain at least one number.";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character.";
    }

    return null;
  }

  // validate confirm password
  String? validateConfirmPassword(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "Confirm Password cannot be empty.";
    }

    return null;
  }

  // Dispose method to clean up resources
  void dispose() {
    contFirstName.dispose();
    contLastName.dispose();
    contEmail.dispose();
    contGender.dispose();
    contPhoneNumber.dispose();
    contPassword.dispose();
    contAddress.dispose();
    contCountry.dispose();
    contState.dispose();
    contCity.dispose();
    contZipcode.dispose();
    contPassword.dispose();
    contConfirmPassword.dispose();
    contDOB.dispose();
  }
}
