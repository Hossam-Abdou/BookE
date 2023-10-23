import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/custom_button.dart';
import '../model/books_model.dart';
import '../view_model/home_cubit.dart';

class CategoryDetailsScreen extends StatelessWidget {
  dynamic id;

  CategoryDetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to cart Successfully'),
            backgroundColor: CustomColors.greyText,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is AddFavSuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to Favourites Successfully'),
            backgroundColor: CustomColors.greyText,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          '${id?.image}',
                          height: 280.h,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: EdgeInsets.all(28.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                child: IconButton(
                                  onPressed: () {
                                    if (cubit.wishListModel!.data!.dataInfo!
                                        .any((item) => item.id == id.id)) {
                                      cubit.removeFav(id: id.id ?? 0);
                                    } else {
                                      cubit.addToFav(
                                        id: id.id ?? 0,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: cubit.wishListModel!.data!.dataInfo!
                                            .any((item) => item.id == id!.id)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                        width: 210.w,
                        child: Text(
                          '${id?.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, fontSize: 25.sp),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cubit.categoryDetailsModel?.data?.name}',
                          style: GoogleFonts.roboto(
                              color: Colors.grey[600], fontSize: 18.sp),
                        ),
                        Column(
                          children: [
                            Text(
                              '${id?.price}',
                              style: GoogleFonts.roboto(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red[300],
                                  fontSize: 13),
                            ),
                            Text(
                              '${id?.priceAfterDiscount}',
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text('${id.description}'),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0.h),
                      child: ConditionalBuilder(
                        condition: state is AddCartLoadingState,
                        fallback: (context) => InkWell(
                          onTap: () {
                            cubit.addToCart(id: id!.id!);
                          },
                          child: CustomButton(
                            text: 'Add to Cart',
                            color: CustomColors.primaryButton,
                          ),
                        ),
                        builder: (context) => Center(
                            child: CircularProgressIndicator(
                          color: CustomColors.primaryButton.withOpacity(0.5),
                        )),
                      ),
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
