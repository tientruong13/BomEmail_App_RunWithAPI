import 'package:flutter/material.dart';

class TextFirldWidget extends StatelessWidget {
  const TextFirldWidget({
    super.key,
    required this.controller,
    required this.text,
    this.keyboardType,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType? keyboardType;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: text,
        icon: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
    );
  }
}
