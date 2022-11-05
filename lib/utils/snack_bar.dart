import 'package:flutter/material.dart';

void displaySnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(createSnackBar(text: text));
}

SnackBar createSnackBar({required String text}) {
  return SnackBar(
    content: Text(text),
  );
}
