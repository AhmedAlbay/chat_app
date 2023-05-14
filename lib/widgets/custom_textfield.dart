import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  textformfield({this.onchanged, this.hinttext});
  String? hinttext;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
