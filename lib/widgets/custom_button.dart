// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

class button extends StatelessWidget {
  button({Key? key,  this.onTap, required this.tittle}) : super(key: key);
  VoidCallback? onTap;
  String tittle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            tittle,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
