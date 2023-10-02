import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/screens/home_screen.dart';
import 'package:untitled4/utils/widgets/custom_button.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/second_text_field.dart';
import 'layout/home.dart';

class CheckOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is AddCartSuccessState)
          {
            SnackBar snackBar =  SnackBar(
              content: const Text('Order placed successfully'),
              backgroundColor: CustomColors.greyText,
              duration: const Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            pushReplace(context, Home());
          }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0.w),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0.h),
                  child: Column(
                    children: [
                      SecondCustomField(
                        controller: cubit.nameController,
                        label: 'Name',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.emailController,
                        label: 'Email',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.phoneController,
                        label: 'Phone',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SecondCustomField(
                        controller: cubit.addressController,
                        label: 'Address',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ExpansionTile(
                          title: Text(
                            'City',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.black,
                                fontSize: 18.sp),
                          ),
                          children: [
                            Container(
                              height: 190.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 5.h,
                                ),
                                itemCount: cubit.cityModel!.data!.length ?? 0,
                                itemBuilder: (context, index) => RadioListTile(
                                    title: Text(
                                      "${cubit.cityModel!.data![index].governorateNameEn}",
                                      style: GoogleFonts.roboto(
                                          color: CustomColors.black,
                                          fontSize: 18.sp),
                                    ),
                                    value: cubit.cityModel!.data![index].id,
                                    groupValue: cubit.index,
                                    onChanged: (value) =>
                                        cubit.getFilter(value)),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10.h,
                      ),

                      Divider(color: CustomColors.greyText),
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.h,
                        ),
                        itemCount:
                            cubit.cartModel?.data?.cartItems?.length ?? 0,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            '${cubit.cartModel?.data?.cartItems![index].itemProductName}',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'quantity:${cubit.cartModel?.data?.cartItems![index].itemQuantity}'),
                          trailing: Text(
                              '${cubit.cartModel?.data?.cartItems![index].itemTotal}'),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(cubit.index);
                          cubit.placeOrder();
                        },
                        child: CustomButton(
                          text: 'Place Order',
                        ),
                      ),
                    ],
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
