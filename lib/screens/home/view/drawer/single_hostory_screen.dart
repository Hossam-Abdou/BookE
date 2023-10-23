import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';
import 'package:screenshot/screenshot.dart';


class SingleHistoryScreen extends StatelessWidget {
  final int? orderId;
  SingleHistoryScreen({this.orderId});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is a) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File Saved to Gallery'),
            ),
          );
        }

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Screenshot(
          controller:cubit.screenshotController,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(15.0),
              child: SafeArea(
                child: cubit.state is GetSingleOrderHistoryLoadingState
                    ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.primaryButton.withOpacity(0.5),
                  ),
                )
                    : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Name : ${cubit.singleOrderHistoryModel?.data
                            ?.name}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        Text('Email : ${cubit.singleOrderHistoryModel?.data
                            ?.email}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        Text('Address : ${cubit.singleOrderHistoryModel?.data
                            ?.address}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        Text('Phone : ${cubit.singleOrderHistoryModel?.data
                            ?.phone}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        Text('Date : ${cubit.singleOrderHistoryModel?.data
                            ?.orderDate}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        Text('Code : ${cubit.singleOrderHistoryModel?.data
                            ?.orderCode}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                        SizedBox(height: 10.h,),

                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                            itemCount: cubit.singleOrderHistoryModel?.data?.orderProducts?.length??0,
                            itemBuilder: (context, index) =>
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CustomColors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    title: Text('${cubit.singleOrderHistoryModel?.data?.orderProducts?[index].productName}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    subtitle: Text('Quantity: ${cubit.singleOrderHistoryModel?.data?.orderProducts?[index].orderProductQuantity} Piece'),
                                    trailing: Text('Price ${cubit.singleOrderHistoryModel?.data?.orderProducts?[index].productTotal} L.E'),

                                  ),
                                ),

                          ),

                        ),
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:CustomColors.primaryButton,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(' Total Price  ',style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, color: Colors.white),),
                              Container(
                                height: 45.h,
                                width: 100.w,

                                child: Center(child:
                                Text('${cubit.singleOrderHistoryModel?.data?.total ??
                                    '0.0'} L.E',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold, color: Colors.cyan),),
                                ),
                              )
                            ],

                          ),
                        ),
                    ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 63.0),
              child: CircleAvatar(

                backgroundColor: Colors.black,
                radius: 28.r,
                child: FloatingActionButton(
                  backgroundColor: CustomColors.primaryButton,

                  onPressed: cubit.takeScreenshotAndSave,

                  child: Icon(Icons.print),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
