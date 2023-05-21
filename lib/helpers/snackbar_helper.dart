import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: message.contains('failed') ? Colors.red : Colors.grey,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
