// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names

  import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void ShowSnakBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }