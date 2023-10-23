import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:untitled4/screens/home/view/details_screen.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/widgets/navigate.dart';
import '../../../../utils/colors/custom_colors.dart';

class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddFavSuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to Favourites Successfully'),
            backgroundColor: CustomColors.greyText,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is RemoveFavSuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Removed from Favourites Successfully'),
            backgroundColor: CustomColors.greyText,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is AddCartSuccessState) {
          SnackBar snackBar = SnackBar(
            content: Text('Added to cart Successfully'),
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
              padding: EdgeInsets.all(10.0.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemCount: cubit.booksModel?.data?.products?.length ?? 0,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          pushNavigate(
                              context,
                              DetailsScreen(
                                id: cubit.booksModel?.data?.products?[index],
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueGrey)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  '${cubit.booksModel?.data?.products?[index].image}',
                                  height: 125.h,
                                  // errorBuilder: (context, error, stackTrace) =>
                                  //     Image.network(
                                  //         'https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg'),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                height: 125.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 150.w,
                                        child: Text(
                                          '${cubit.booksModel?.data?.products?[index].name}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Text(
                                        '${cubit.booksModel?.data?.products?[index].category}',
                                        style:
                                            TextStyle(fontStyle: FontStyle.italic)),
                                    Spacer(),
                                    Text(
                                        '${cubit.booksModel?.data?.products?[index].price} L.E',
                                        style: GoogleFonts.roboto(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.red[300],
                                          fontSize: 13,
                                        )),
                                    Text(
                                      '${cubit.booksModel?.data?.products?[index].priceAfterDiscount} L.E',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 125.h,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if(cubit.wishListModel!.data!.dataInfo!.any((item) => item.id == cubit.booksModel?.data?.products?[index].id))
                                          {
                                            cubit.removeFav(id: cubit.booksModel?.data?.products?[index].id ?? 0);
                                          }
                                        else{
                                          cubit.addToFav(
                                            id: cubit.booksModel?.data?.products?[index].id ?? 0,
                                          );
                                        }
                                      },
                                      icon:  Icon(
                                        cubit.wishListModel!.data!.dataInfo!.any((item) => item.id == cubit.booksModel?.data?.products?[index].id)
                                            ? Icons.favorite
                                            : Icons.favorite_border_rounded,
                                        color: cubit.wishListModel!.data!.dataInfo!.any((item) => item.id == cubit.booksModel?.data?.products?[index].id)
                                            ? Colors.red
                                            : CustomColors.primaryButton,
                                      ),
                                      ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        cubit.addToCart(
                                            id: cubit.booksModel?.data
                                                    ?.products?[index].id ??
                                                0);
                                      },
                                      icon: Icon(
                                        Icons.add_shopping_cart_rounded,
                                        color: CustomColors.primaryButton,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

