// ignore_for_file: must_be_immutable, camel_case_types, body_might_complete_normally_nullable, prefer_const_constructors

import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  textformfield({Key? key, this.onchanged, this.hinttext, this.obscureText = false}) : super(key: key);
  String? hinttext;
  Function(String)? onchanged;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return "Please enter a value";
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
