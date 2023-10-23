import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors/custom_colors.dart';
import 'home/view_model/home_cubit.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: CustomColors.primaryButton,
            items: cubit.items,
            index: cubit.currentindex,
            height: 50.h,
            onTap: (currentIndex) => cubit.changecurrentindex(currentIndex),
          ),
          body: cubit.layouts[cubit.currentindex],
        );
      },
    );;
  }
}
