import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/custom_colors.dart';

class CustomField extends StatelessWidget {
  String? label;
  int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? initial;
  final Widget? pIcon;
  final Widget? sIcon;

  CustomField(
      {required this.label,
      required this.controller,
      this.maxLines,
      this.validator,
        this.pIcon,
        this.sIcon,
      this.initial});
  @override
  Widget build(BuildContext context) {
  controller.text = initial ?? controller.text;
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,

      validator: validator,
      cursorColor: CustomColors.black,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: sIcon,
          prefixIcon: pIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          //prefixIcon: Icon(prefix),
          prefixIconColor: Color.fromARGB(255, 5, 110, 196),
          label: Text("$label",
              style: TextStyle(color: CustomColors.primaryButton)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Color.fromARGB(255, 226, 16, 16))),
          // suffixIcon: suffix,
          suffixIconColor: Color.fromARGB(255, 5, 110, 196)),
    );
  }
}
