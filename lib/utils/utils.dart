import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_assignment/componets/textview.dart';

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

void appLog(dynamic message) {
  if (kDebugMode) print(message);
}

TextStyle commonTextStyle(
    {Color color = Colors.black,
    double fontSize = 12,
    TextDecoration decoration = TextDecoration.none,
    fontWeight = FontWeight.w500}) {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 0.4,
          decoration: decoration));
}

void showSnackbar(String msg) {
  GetSnackBar(
    duration: Duration(seconds: 5),
    dismissDirection: DismissDirection.horizontal,
    animationDuration: const Duration(milliseconds: 300),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.OPENING ||
          status == SnackbarStatus.CLOSED) {}
      appLog("status ------> $status");
    },
    messageText:
        TextView(title: msg, textStyle: commonTextStyle(color: Colors.white)),
  ).show();
}

goToNextScreen(dynamic screenWidget, String routeName) {
  Navigator.of(Get.context!).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screenWidget;
        },
        settings: RouteSettings(name: routeName),
      ),
      (route) => false);
}
