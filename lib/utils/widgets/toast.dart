// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void showToast({
//     required msg,
//     required bool isError,
//     Color? textColor,
//     double? fontSize,
// }) =>
//     Fluttertoast.showToast(
//         msg: msg.toString(),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         textColor: textColor,
//         gravity: ToastGravity.BOTTOM,
//         fontSize: fontSize,
//     );
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green[700],
    textColor: Colors.white,
  );
}