import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  ToastMessage({required this.message, this.useTheme}) {
    toast(message, useTheme: useTheme ?? false);
  }

  final String message;
  final bool? useTheme;

  static Future toast(String msg, {bool useTheme = false}) {
    return Fluttertoast.showToast(
      backgroundColor: useTheme ? Colors.blue : null,
      textColor: useTheme ? Colors.white : null,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
