import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/authenticate/view/reset_password_screen.dart';

import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_field.dart';
import '../../../utils/widgets/navigate.dart';

class CheckForgetPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CheckForgetPassSuccessState) {
          SnackBar snackBar =  SnackBar(
            content: const Text('Verified Successfully'),
            backgroundColor: CustomColors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          pushReplace(context, ResetPassScreen());
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Verification', style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold, fontSize: 18.sp,color: Colors.black),),
          ),
          body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.all(20.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child:  Text('Enter Verification Code We just sent you on your email address',style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, color: CustomColors.greyText),),),
                  SizedBox(height: 15.h,),

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
                      inactiveColor: CustomColors.primaryButton.withOpacity(0.4),
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.grey[300],
                    ),
                    length: 6,
                    onChanged: (value) {
                      print(value);
                    },
                    onCompleted: (v) {
                      cubit.checkForgetPass();
                    },
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    animationType: AnimationType.fade,
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    controller: cubit.verifyPasswordController,
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),

                  SizedBox(height: 10.h,),

                  InkWell(
                      onTap: ()
                      {
                        cubit.checkForgetPass();
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: CustomButton(text: 'Verify',color: Colors.black, ),
                      )),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('If you didn\'t recieve code'),
                      TextButton(
                        onPressed: ()
                        {
                          cubit.resendVerifyEmail();
                        },
                        child: Text('Resend',style: GoogleFonts.roboto(color: CustomColors.primaryButton),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
