import 'package:flutter/material.dart';


class SecondCustomField extends StatelessWidget {
  String? label;
  final TextEditingController controller;
  final String? initial;

  SecondCustomField(
      {
        required this.label,
        required this.controller,
        this.initial
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: initial ?? '00',
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        disabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12),),

      ),
    );
  }
}
