import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorToast({required BuildContext context, required String message}) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red,
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(8),
    icon: const Icon(Icons.error, color: Colors.white),
  ).show(context);
}
