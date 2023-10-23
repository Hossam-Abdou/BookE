import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view/drawer/single_hostory_screen.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>SizedBox(height: 10.h,),
              itemCount: cubit.orderHistoryModel?.data?.orders?.length??0,
              itemBuilder: (context, index) =>
            ListTile(
              title: Text('order Code: ${cubit.orderHistoryModel?.data?.orders?[index].orderCode}'),
              subtitle: Text('Date: ${cubit.orderHistoryModel?.data?.orders?[index].orderDate}'),
              trailing: GestureDetector(
                onTap: ()
                {
                  cubit.getSingleOrderHistory(cubit.orderHistoryModel?.data?.orders?[index].id);
                  pushNavigate(context, SingleHistoryScreen(orderId: cubit.orderHistoryModel?.data?.orders?[index].id));
                },
                child: Container(
                  height: 30.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: CustomColors.primaryButton),
                    color: CustomColors.primaryButton

                  ),
                    child: Center(child: Text('Details',style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.bold),))),
              ),
            ),

          ),
        );
      },
    );
  }
}
