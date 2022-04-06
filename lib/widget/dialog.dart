import 'package:flutter/material.dart';

void showsnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 5),
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
    ),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
