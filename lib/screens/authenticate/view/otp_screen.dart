import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home_screen.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyEmailSuccessState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset('images/otp.json',
                      width: 300.w, height: 260.h),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    'Verify Your Email',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp, fontWeight: FontWeight.bold,height: 2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    'Code sent to your email : jojsoajdoj@maso.com',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  appContext: context,
                  autoFocus: true,
                  pinTheme: PinTheme(
                    activeColor: Colors.blueGrey,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50.h,
                    fieldWidth: 40.w,
                    selectedFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    activeFillColor: Colors.grey[300],
                  ),
                  length: 6,
                  onChanged: (value) {
                    print(value);
                  },
                  onCompleted: (v) {
                    cubit.verifyEmail();
                  },
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  animationType: AnimationType.fade,
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  controller: cubit.pinController,
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
