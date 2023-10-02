import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/authenticate/view/otp_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_field.dart';
import '../../home_screen.dart';
import 'login_screen.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is UserRegisterSuccessState) {

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(),
              ));

          const snackBar = SnackBar(
            content: Text('Register Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is UserRegisterErrorState) {
          const snackBar = SnackBar(
            content: Text('Password or Email is not correct'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Form(
          key: cubit.regKey,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Let’s get started!',
                          style: GoogleFonts.roboto(
                              fontSize: 34.sp, color: CustomColors.black),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            'create an account and start booking now.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: CustomColors.greyText),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomField(
                          controller: cubit.nameController,
                          label: 'Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Field Can\'t Be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomField(
                          controller: cubit.emailController,
                          label: 'Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Field Can\'t Be Empty';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Please Enter Valid E-Mail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
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
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomField(
                          controller: cubit.confirmController,
                          label: 'Confirm Password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'The Field Can\'t Be Empty';
                            }
                            if (cubit.passwordController.text !=
                                cubit.confirmController.text) {
                              return 'The Password s not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  color: CustomColors.greyText),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                                child: Text(
                                  'Login here',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      color: CustomColors.greyText),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        ConditionalBuilder(
                          condition: state is UserRegisterLoadingState,
                          builder: (context) => Center(
                              child: CircularProgressIndicator(
                            color: CustomColors.primaryButton,
                          )),
                          fallback: (context) => InkWell(
                            onTap: () {
                              if (cubit.regKey.currentState!.validate()) {
                                cubit.Register();
                                cubit.email=cubit.emailController.text;
                              }
                            },
                            child: CustomButton(text: 'Register'),
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
