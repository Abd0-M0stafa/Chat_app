// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void CustomSnakeBar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
    ),
  );
}
