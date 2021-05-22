import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {@required this.hint,
      @required this.onChanged,
      this.keyboardType,
      this.obscureText});

  final String hint;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
