import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view/details_screen.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../../utils/colors/custom_colors.dart';

class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is AddFavSuccessState)
        {
          SnackBar snackBar =  SnackBar(
            content: Text('Added to Favourites Successfully'),
            backgroundColor: CustomColors.greyText,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if(state is AddCartSuccessState)
        {
          SnackBar snackBar =  SnackBar(
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
              padding:  EdgeInsets.all(10.0.w),
              child: ListView.separated(
                shrinkWrap: true,
                  separatorBuilder: (context, index) =>SizedBox(height: 10.h,) ,
                  itemCount: cubit.booksModel?.data?.products?.length??0,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: ()
                        {
                          pushNavigate(context, DetailsScreen(id:cubit.booksModel?.data?.products?[index] ,));
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueGrey)
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network('${cubit.booksModel?.data?.products?[index].image}',height: 125.h,errorBuilder: (context, error, stackTrace) => Image.network('https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg'),)),
                              SizedBox(width: 10.w,),
                              SizedBox(
                                height: 125.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width:150.w,
                                        child: Text('${cubit.booksModel?.data?.products?[index].name}',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)),
                                    Text('${cubit.booksModel?.data?.products?[index].category}',style:TextStyle(fontStyle: FontStyle.italic)),
                                    Spacer(),
                                    Text('${cubit.booksModel?.data?.products?[index].price} L.E',style: GoogleFonts.roboto(decoration: TextDecoration.lineThrough,color: Colors.red[300],fontSize: 13,)),
                                    Text('${cubit.booksModel?.data?.products?[index].priceAfterDiscount} L.E',style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(height: 125.h,
                                child: Column(
                                  children: [
                                    IconButton(onPressed: (){
                                      cubit.addToFav(id: cubit.booksModel?.data?.products?[index].id ?? 0);
                                    },
                                      icon: Icon(Icons.favorite_border_outlined,color: Colors.blueGrey,),),
                                    Spacer(),
                                    IconButton(onPressed: ()
                                    {
                                      cubit.addToCart(id: cubit.booksModel?.data?.products?[index].id ?? 0);
                                    },
                                      icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.blueGrey,),),


                                  ],
                                ),
                              ),

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
// CustomDesign(
// name: '${cubit.booksModel?.data?.products?[index].name}',
// price: '${cubit.booksModel?.data?.products?[index].price}',
// category: '${cubit.booksModel?.data?.products?[index].category}',
// description: '${cubit.booksModel?.data?.products?[index].description}',
// priceAfter: '${cubit.booksModel?.data?.products?[index].priceAfterDiscount}',
// image: '${cubit.booksModel?.data?.products?[index].image}',
// ),
