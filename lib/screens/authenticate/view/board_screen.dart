import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled4/screens/authenticate/view/register_screen.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../utils/colors/custom_colors.dart';
import '../view_model/authentication_cubit.dart';
import 'login_screen.dart';


class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.primaryButton,
            actions: [
              TextButton(
                  onPressed: () {
                    pushReplace(context, LoginScreen());
                  },
                  child: Text('Skip', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0.sp,
                        color: Colors.white),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0.w),
            child: Column(children: [
              Expanded(
                child: PageView.builder(
                  itemCount: cubit.board.length,
                  onPageChanged: (index) {
                    cubit.onBoardChange(index);
                  },
                  physics: BouncingScrollPhysics(),
                  controller: cubit.boardController,
                  itemBuilder: (context, index) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset('${cubit.board[index].image}',
                          width: 200.w, height: 350.h, fit: BoxFit.cover),

                      SizedBox(height: 10.0.h),
                      Animate(
                        effects: [
                          FlipEffect(
                              direction: Axis.vertical, duration: Duration(seconds: 1))
                        ],
                        child: Text(
                          '${cubit.board[index].title}',
                          style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      Text('${cubit.board[index].body}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0.h),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: cubit.boardController,
                    count: cubit.board.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: CustomColors.primaryButton,
                      expansionFactor: 4.0,
                      dotWidth: 16.0,
                      dotHeight: 16.0,
                      spacing: 8.0,
                      dotColor: CustomColors.greyText,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                      backgroundColor: CustomColors.primaryButton,
                      onPressed: () {
                        if (cubit.isLast) {
                          pushReplace(context, RegisterScreen());
                        } else {
                          cubit.boardController.nextPage(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeOutCirc);
                        }
                      },
                      child: Icon(Icons.arrow_forward))
                ],
              )
            ]),
          ),
        );
      },
    );
  }

}
