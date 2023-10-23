import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:untitled4/utils/widgets/custom_field.dart';
import 'package:untitled4/utils/widgets/custom_field.dart';

import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/second_text_field.dart';

class UpdatePassScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is UpdatePassSuccessState)
          {

            SnackBar snackBar =  SnackBar(
              content: const  Text('Password Updated Successfully'),
              backgroundColor: CustomColors.black,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        if(state is UpdatePassErrorState)
        {

          SnackBar snackBar =  SnackBar(
            content: const  Text('Password Error'),
            backgroundColor: CustomColors.greyText,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Form(
          key: cubit.updatePassKey,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Update Your Password ',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                    SizedBox(height: 20.h,),
                    CustomField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return 'The Field Can\'t Be Empty';
                              }
                              return null;
                            },
                      controller: cubit.passwordController,
                      label: 'Password',
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
                          if (cubit.updatePassKey.currentState!.validate())
                          {
                            cubit.updatePass();
                          }
                        },
                        child: CustomButton(text: 'Change Password',color: CustomColors.primaryButton,),),
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
