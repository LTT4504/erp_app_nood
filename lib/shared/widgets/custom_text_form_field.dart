import 'package:flutter/material.dart';
import 'package:work_manager/shared/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Color primaryColor;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffix;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.primaryColor,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffix,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: primaryColor),
        suffixIcon: suffix,
        labelStyle: TextStyle(color: primaryColor),
        hintStyle: TextStyle(color: primaryColor.withValues(alpha: 0.6)),
        filled: true,
        fillColor: readOnly ? Colors.grey.shade200 :  ColorConstants.white, // mờ khi khóa
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
