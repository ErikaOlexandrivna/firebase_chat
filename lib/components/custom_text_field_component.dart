import 'package:flutter/material.dart';

class CustomTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  final String label;
  final bool obscureText;

  const CustomTextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          prefixIcon: icon,
          labelText: label),
    );
  }
}
