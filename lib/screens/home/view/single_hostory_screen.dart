import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/utils/colors/custom_colors.dart';

class SingleHistoryScreen extends StatelessWidget {
  final int? orderId;

  SingleHistoryScreen({this.orderId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) =>ListTile(

                  title: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: ,
                            ),
                          )
                          Text('${cubit.singleOrderHistoryModel?.data?.phone}'),
                          Text('${cubit.singleOrderHistoryModel?.data?.phone}'),
                        ],
                      ),
                      SizedBox(width: 20.w,),
                      Column(
                        children: [
                          Text('${cubit.singleOrderHistoryModel?.data?.email}'),
                          Text('${cubit.singleOrderHistoryModel?.data?.email}'),
                        ],
                      ),
                    ],
                  ),
                  leading: Text('${cubit.singleOrderHistoryModel?.data?.name}'),
                  trailing: Text('${cubit.singleOrderHistoryModel?.data?.total}'),
              ),
              separatorBuilder: (context, index) =>SizedBox(height: 10.h,),
              itemCount:1),
        );
      },
    );
  }
}
