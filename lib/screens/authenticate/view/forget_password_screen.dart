import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/authenticate/view/check_forget_password_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:untitled4/utils/widgets/custom_button.dart';
import 'package:untitled4/utils/widgets/custom_field.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

class ForgetPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendForgetPassSuccessState) {
          SnackBar snackBar =  SnackBar(
            content: Text('Code Sent To your email'),
            backgroundColor: CustomColors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          pushReplace(context, CheckForgetPasswordScreen());
        }
        },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text('Forget Password ?', style: GoogleFonts.roboto(
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
                      child:  Text('  Enter the Email address associated with your account',style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, color: CustomColors.greyText),),),
                  SizedBox(height: 6.h,),
                   Text('We will email you a link to reset your password',style: GoogleFonts.roboto(color: CustomColors.greyText.withOpacity(0.5))),
                  SizedBox(height: 15.h,),

                  SizedBox(
                      height: 45.h,
                      child: CustomField(label: 'Email', controller: cubit.emailController)),
                  SizedBox(height: 15.h,),

                  ConditionalBuilder(
                    condition: state is SendForgetPassLoadingState,
                    builder: (context) => Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.primaryButton,
                        )),
                    fallback: (context) => InkWell(
                        onTap: ()
                        {
                          cubit.sendForgetPass();
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: CustomButton(text:'Send',color: Colors.black, ),
                        ),),
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
