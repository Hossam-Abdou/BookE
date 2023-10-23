import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/authenticate/view/login_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:untitled4/utils/widgets/custom_field.dart';
import 'package:untitled4/utils/widgets/custom_field.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/second_text_field.dart';

class ResetPassScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is ResetPassSuccessState)
        {

          SnackBar snackBar =  SnackBar(
            content: const  Text('Password Updated Successfully'),
            backgroundColor: CustomColors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          pushReplace(context, LoginScreen());
        }
        if(state is ResetPassErrorState)
        {

          SnackBar snackBar =  SnackBar(
            content: const  Text('Password Error'),
            backgroundColor: CustomColors.greyText,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit=AuthCubit.get(context);
        return Form(
          key: cubit.resetKey,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Reset Your Password ',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                    SizedBox(height: 20.h,),
                    CustomField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field Can\'t Be Empty';
                        }
                        return null;
                      },
                      controller: cubit.verifyyPasswordController,
                      label: 'Verify Password',
                    ),
                    SizedBox(
                      height: 20.h,

                    ),
                    CustomField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field Can\'t Be Empty';
                        }
                        return null;
                      },
                      controller: cubit.newPasswordController,
                      label: 'New Password',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomField(
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return 'The Field Can\'t Be Empty';
                        }
                        if(cubit.newPasswordController.text!=cubit.confirmNewPasswordController.text)
                        {
                          return 'The Password s not match';
                        }

                        return null;
                      },

                      controller: cubit.confirmNewPasswordController,
                      label: 'Confirm New Password',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ConditionalBuilder(
                      condition: state is UpdatePassLoadingState,
                      fallback:(context)=>   InkWell(
                        onTap: ()
                        {

                            cubit.resetPassword();


                        },
                        child: CustomButton(text: 'Reset Your Password',color: CustomColors.primaryButton,),),
                      builder: (context) => Center(child: CircularProgressIndicator(color: CustomColors.primaryButton.withOpacity(0.5),)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
