import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled4/screens/home/view/details_screen.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_design.dart';
import '../view_model/home_cubit.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final int? id;

  CategoriesDetailsScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // Rest of the code
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        if (state is GetCategoriesDetailsLoadingState) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,

                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                            height: 100.0,
                            color: Colors.black,
                            // Placeholder widget to show shimmer effect
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: 10, // Number of shimmer placeholders
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  Text(
                    '${cubit.categoryDetailsModel?.data?.name} Category',
                    style: GoogleFonts.roboto(
                      fontSize: 24.sp,
                      color: const Color(0xff2f0569),
                    ),
                  ),
                  SizedBox(height: 7.h,),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CustomDesign(
                        name: '${cubit.categoryDetailsModel?.data?.products?[index].name}',
                        price: '${cubit.categoryDetailsModel?.data?.products?[index].price}',
                        priceAfter: '${cubit.categoryDetailsModel?.data?.products?[index].priceAfterDiscount}',
                        image: '${cubit.categoryDetailsModel?.data?.products?[index].image}',
                        onPressed: () => cubit.addToFav(id: cubit.categoryDetailsModel?.data?.products?[index].id ?? 0),
                        SecondOnPressed: () => cubit.addToCart(id: cubit.categoryDetailsModel?.data?.products?[index].id ?? 0),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemCount: cubit.categoryDetailsModel?.data?.products?.length ?? 0,
                    ),
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