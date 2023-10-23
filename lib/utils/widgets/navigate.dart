import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void pushNavigate(context, Widget) => Navigator.push(context,
  MaterialPageRoute(builder: (context) => Widget),);


void pushReplace(context, Widget) => Navigator.pushReplacement(context,
  MaterialPageRoute(builder: (context) => Widget),);
