import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  void showAwesomeSnackBar(BuildContext context, String title, String message, ContentType contentType) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 800),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(title: title, message: message, contentType: contentType),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
