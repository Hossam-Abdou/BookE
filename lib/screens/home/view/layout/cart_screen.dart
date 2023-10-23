import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view/checkout_screen.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is RemoveCartSuccessState)
          {
            SnackBar snackBar =  SnackBar(
              content: Text('Removed From cart'),
              backgroundColor: CustomColors.greyText,
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      },
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding:  EdgeInsets.all(10.0.w),
            child: SafeArea(
              child: cubit.cartModel?.data?.cartItems?.length== 0 ?
              Center(child: Text('The Cart Is Empty',style: TextStyle(color: CustomColors.primaryButton,fontSize: 20.sp),),):
              Column(
                children: [

                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                       itemCount: cubit.cartModel?.data?.cartItems?.length??0,
                       itemBuilder:(context, index) =>
                       Container(
                         padding: EdgeInsets.all(6.w),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: Colors.blueGrey)
                         ),
                         child: Row(
                           children: [
                             ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image.network('${cubit.cartModel!.data!.cartItems![index].itemProductImage}',height: 125.h,)),
                             SizedBox(width: 10.w,),
                             SizedBox(height: 115.h,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                      width:150.w,
                                       child: Text('${cubit.cartModel!.data!.cartItems![index].itemProductName}',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 14),)),
                                   Spacer(),
                                   Container(
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           border: Border.all(color: Colors.blueGrey,),),
                                     child: Row(
                                       children: [
                                         IconButton(onPressed: ()
                                         {

                                           int? currentQuantity = cubit.cartModel!.data!.cartItems![index].itemQuantity;
                                           cubit.updateCart(id:cubit.cartModel!.data!.cartItems![index].itemId??0,quantity: currentQuantity! + 1 );
                                         }, icon: Icon(Icons.add)),
                                         Text('${cubit.cartModel!.data!.cartItems![index].itemQuantity}'),
                                         IconButton(
                                           onPressed: () {
                                             int? currentQuantity = cubit.cartModel!.data!.cartItems![index].itemQuantity;
                                             if (currentQuantity! > 1) {
                                               cubit.updateCart(id: cubit.cartModel!.data!.cartItems![index].itemId??0, quantity: currentQuantity - 1);
                                             } else {

                                             }
                                           },
                                           icon: Icon(Icons.remove),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Spacer(),
                             SizedBox(height: 125.h,
                               child: Column(

                                 children: [

                                   IconButton(onPressed: ()
                                   {
                                     print(cubit.cartModel!.data!.cartItems![index].itemId);
                                     cubit.removeCart(id:cubit.cartModel?.data?.cartItems?[index].itemId ??0);
                                   },
                                       icon: Icon(Icons.delete_rounded,color: Colors.grey),),




                                   Spacer(flex: 12,),
                                   Text('${cubit.cartModel!.data!.cartItems![index].itemProductPrice}',
                                     style: GoogleFonts.roboto(
                                       decoration: TextDecoration.lineThrough,
                                       color: Colors.red[300]
                                         ,fontSize: 13
                                     ),),
                                   Spacer(flex: 1,),
                                   Text('${cubit.cartModel!.data!.cartItems![index].itemProductPriceAfterDiscount}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold),),

                                 ],
                               ),
                             ),

                           ],
                         ),
                       )),
                ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.only(top: 5.0.h,bottom: 5.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w
                      ),
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: CustomColors.primaryButton.withOpacity(0.5),
                        border: Border.all( color:CustomColors.primaryButton.withOpacity(0.7),width: 3)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(

                              text: TextSpan(children: [

                                TextSpan(text:'     Total Price is : ',style: GoogleFonts.roboto(color: Colors.white) ),
                                TextSpan(text:'${cubit.cartModel!.data!.total??'0.0'} L.E' ,style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white)),
                              ]),
                          ),
                          InkWell(
                            onTap: ()
                            {
                              pushNavigate(context, CheckOutScreen());
                            },
                            child: Container(
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,

                              ),
                              child: Center(child: Text('CheckOut',style: GoogleFonts.roboto(fontWeight: FontWeight.w900,color:CustomColors.primaryButton,),),),
                            ),
                          )
                        ],

                      ),
                    ),
                  )
              ],),
            ),
          ),
        );
      },
    );
  }
}
