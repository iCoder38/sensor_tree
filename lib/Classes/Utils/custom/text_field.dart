import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color borderColor;
  final String? Function(String?)? validator;
  final GestureTapCallback? onTap; // Optional onTap parameter

  const CustomTextField({
    super.key,
    required this.hintText,
    this.readOnly = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.borderColor = Colors.black,
    this.validator,
    this.onTap, // Initialize onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap, // Assign onTap to TextFormField's onTap
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: borderColor) : null,
        suffixIcon:
            suffixIcon != null
                ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon, color: borderColor),
                )
                : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
