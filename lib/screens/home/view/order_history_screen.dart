import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/screens/home/view/single_hostory_screen.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
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
              separatorBuilder: (context, index) =>SizedBox(height: 10.h,),
              itemCount: cubit.orderHistoryModel?.data?.orders?.length??0,
              itemBuilder: (context, index) =>
            GestureDetector(
              onTap: ()
              {
                // name - email -- address -phone - total - date  - governorate -
                cubit.getSingleOrderHistory(cubit.orderHistoryModel?.data?.orders?[index].id);
                pushNavigate(context, SingleHistoryScreen(orderId: cubit.orderHistoryModel?.data?.orders?[index].id));
              },
              child: ListTile(
                leading: SizedBox(
                  width: 50.w,
                    child: Text('Click for more details')),
                title: Text('order Code: ${cubit.orderHistoryModel?.data?.orders?[index].orderCode}'),
                subtitle: Text('Date: ${cubit.orderHistoryModel?.data?.orders?[index].orderDate}'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),

          ),
        );
      },
    );
  }
}
