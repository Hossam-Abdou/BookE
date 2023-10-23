import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';

import '../../../../utils/colors/custom_colors.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state)
      {
        if(state is RemoveFavSuccessState)
        {
          SnackBar snackBar =  SnackBar(
            content: Text('Removed From Favourites Successfully'),
            duration: Duration(seconds: 1),

            backgroundColor: CustomColors.greyText,
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
          body: Padding(
            padding:  EdgeInsets.all(14.0.w),
            child: cubit.wishListModel?.data?.dataInfo?.length== 0 ?
            Center(child: Text('No Favourites Yet',style: TextStyle(color: CustomColors.primaryButton,fontSize: 20.sp),)):
            ListView.separated(
                shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 10.h,),
              itemCount: cubit.wishListModel?.data?.dataInfo?.length??0,
                itemBuilder: (context, index) =>
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: CustomColors.primaryButton.withOpacity(0.6),width: 3)
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network('${cubit.wishListModel?.data?.dataInfo?[index].image}',height: 125.h,)),
                         SizedBox(width: 10.w,),
                          SizedBox(
                            height: 125.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:140.w,
                                    child: Text('${cubit.wishListModel?.data?.dataInfo?[index].name}',overflow: TextOverflow.ellipsis,maxLines: 3,style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)),
                                Text('${cubit.wishListModel?.data?.dataInfo?[index].category}',),
                                Spacer(),
                                Text('${cubit.wishListModel?.data?.dataInfo?[index].price} L.E',style: GoogleFonts.roboto(decoration: TextDecoration.lineThrough,color: Colors.red[300],fontSize: 13),),
                                Text('${cubit.finalPrice('${cubit.wishListModel?.data?.dataInfo?[index].price}', '${cubit.wishListModel?.data?.dataInfo?[index].discount}' )} L.E',style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(height: 150.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: ()
                                {
                                  cubit.removeFav(id:cubit.wishListModel?.data?.dataInfo?[index].id ?? 0);
                                },
                                  icon: Icon(Icons.favorite,color: Colors.red[500],),),
                                IconButton(onPressed: ()
                                {
                                  cubit.addToCart(id: cubit.wishListModel?.data?.dataInfo?[index].id ?? 0);
                                },
                                  icon: Icon(Icons.add_shopping_cart_rounded,color: CustomColors.primaryButton,),),

                              ],
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
