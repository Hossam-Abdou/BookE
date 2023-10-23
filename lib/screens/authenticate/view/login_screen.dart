import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/authenticate/view/forget_password_screen.dart';
import 'package:untitled4/screens/authenticate/view/otp_screen.dart';
import 'package:untitled4/screens/authenticate/view/register_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/utils/widgets/navigate.dart';
import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_field.dart';
import '../../home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is UserLoginSuccessState) {
          if(AuthCubit.get(context).authenticateModel!.data!.user!.emailVerified==true)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
          }
          else{
            AuthCubit.get(context).resendVerifyEmail();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreen(),),);

          }

          SnackBar snackBar = SnackBar(
            content: Text('Logged in Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
        if (state is UserLoginErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text('error'),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Form(
            key: cubit.formKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: GoogleFonts.roboto(
                              fontSize: 34.sp, color: CustomColors.black),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            'Login to access your assigned tasks and personal overview.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.greyText),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomField(
                          controller: cubit.emailController,
                          label: 'Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Field Can\'t Be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomField(
                          controller: cubit.passwordController,
                          label: 'Paasword',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Field Can\'t Be Empty';
                            }
                            return null;
                          },
                        ),
                        TextButton(onPressed: ()
                        {
                          pushNavigate(context, ForgetPasswordScreen());
                        },
                            child: Align(
                              alignment: Alignment.centerRight,
                                child: Text('Forget Password?',style: GoogleFonts.roboto(color: CustomColors.greyText,),)),),
                        Row(
                          children: [
                            Checkbox(
                                value: cubit.authenticateCheckBox,
                                activeColor:CustomColors.primaryButton ,
                                onChanged: (value) {
                                  cubit.changeCheck();
                                }),
                            Text(
                              'Keep me Logged in',
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  color: CustomColors.greyText),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'No Account Yet?',
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: CustomColors.greyText),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ));
                                },
                                child: Text(
                                  'Register here',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: CustomColors.primaryButton),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ConditionalBuilder(
                          condition: state is UserLoginLoadingState,
                          builder: (context) => Center(
                              child: CircularProgressIndicator(
                            color: CustomColors.primaryButton,
                          )),
                          fallback: (context) => InkWell(
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.Login();
                              }
                            },
                            child: CustomButton(text: 'Login'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
