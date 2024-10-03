import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar(String message, {String title = 'Error!'}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.redAccent,
    snackPosition: SnackPosition.TOP,
    titleText: Text(title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
    messageText: Text(message,
        style: TextStyle(
          color: Colors.white,
        )),
  );
}

void showRedirectSnackBar(String message, int seconds,
    {String title = 'Success!'}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.greenAccent,
    snackPosition: SnackPosition.TOP,
    titleText: Text(title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
    backgroundGradient: LinearGradient(
      colors: [Colors.greenAccent, Colors.green],
      stops: [0.0, 1.0],
    ),
    animationDuration: Duration(seconds: seconds),
    forwardAnimationCurve: Curves.easeInOut,
    reverseAnimationCurve: Curves.easeInOut,
    colorText: Colors.white,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    showProgressIndicator: true,
    progressIndicatorBackgroundColor: Colors.greenAccent.shade700,
    progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  );
}
