import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.text,
    this.onChanged,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
  });
  final String text;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  Widget? suffixIcon;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color.fromARGB(255, 28, 228, 167),
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      style: const TextStyle(
        color: Color.fromARGB(255, 28, 228, 167),
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: text,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 197, 192, 192)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 28, 228, 167),
          ),
        ),
      ),
    );
  }
}
