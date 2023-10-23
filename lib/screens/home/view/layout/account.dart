import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/widgets/custom_button.dart';

import '../../../../utils/colors/custom_colors.dart';
import '../../../../utils/widgets/second_text_field.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    return BlocProvider.value(
      value: HomeCubit.get(context)..initController(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UpdateAccountSuccessState) {
            SnackBar snackBar = SnackBar(
              content: Text('Profile Updated Successfully'),
              backgroundColor: CustomColors.greyText,
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(14.0.w),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 102.r,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 100.r,
                          backgroundImage: NetworkImage(
                              '${cubit.userProfileModel?.data?.image}'),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.nameController,
                        label: 'Name',
                        pIcon: Icon(
                          Icons.person,
                          color: CustomColors.primaryButton,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.emailController,
                        label: 'Email',
                        pIcon: Icon(
                          Icons.email_outlined,
                          color: CustomColors.primaryButton,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.phoneController,
                        label: 'Phone',
                        pIcon: Icon(
                          Icons.phone,
                          color: CustomColors.primaryButton,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.cityController,
                        pIcon: Icon(
                          Icons.location_city_outlined,
                          color: CustomColors.primaryButton,
                        ),
                        label: 'City',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.addressController,
                        label: 'Address',
                        pIcon: Icon(
                          Icons.location_on_rounded,
                          color: CustomColors.primaryButton,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ConditionalBuilder(
                        condition: state is UpdateAccountLoadingState,
                        fallback: (context) => InkWell(
                          onTap: () {
                            cubit.updateProfile();
                          },
                          child: CustomButton(
                            text: 'Update',
                            color: CustomColors.primaryButton,
                          ),
                        ),
                        builder: (context) => Center(
                            child: CircularProgressIndicator(
                          color: CustomColors.primaryButton.withOpacity(0.5),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
}
