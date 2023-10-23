import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';

import '../../../utils/colors/custom_colors.dart';
import '../../../utils/widgets/navigate.dart';

class Searchscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit(),
  child: BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit=HomeCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                controller: cubit.searchController,

                onChanged: (String value) {
                  cubit.searchBooks(value);
                },
                decoration: InputDecoration(

                  prefixIcon: Icon(Icons.search_outlined,color:CustomColors.primaryButton ,),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: CustomColors.primaryButton.withOpacity(0.8)),

                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: CustomColors.primaryButton),

                  ) ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: CustomColors.primaryButton),

                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: CustomColors.primaryButton),),
                ),
              ),
              SizedBox(height: 10.h,),
              if (state is SearchLoadingState)
                CircularProgressIndicator.adaptive(),
              if (state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.searchModel?.data?.products?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 8.h),
                    itemBuilder: (context, index) => Row(
                      children: [
                        Container(
                          height: 80.h,
                          width: 70.w,
                          child: Image.network('${cubit.searchModel?.data?.products?[index].image}'),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:200.w,
                              child: Text(
                                  '${cubit.searchModel?.data?.products?[index].name}',style: GoogleFonts.roboto(fontWeight: FontWeight.bold),),
                            ),
                            Text('${cubit.searchModel?.data?.products?[index].category}'),
                            SizedBox(height: 5.h,),
                            Text('${cubit.searchModel?.data?.products?[index].price} L.E'),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              // if (state is SearchDoctorsloadingstate)
              //   LinearProgressIndicator(
              //     backgroundColor: CustomColors.primaryButton,
              //     color: Colors.white,
              //   ),
              // if (state is SearchDoctorsSucceessstate)
              // Expanded(
              //     child: ListView.separated(
              //         itemBuilder: (context, index) {
              //           return textinter(
              //               text: searchDoctor?.name! ?? 'ss',
              //               color: CustomColors.primaryButton,
              //               size: 20);
              //         },
              //         separatorBuilder: (context, index) =>
              //             sb(h: 10),
              //         itemCount:
              //             cubit.searchDoctor?.data?.length ?? 0)
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}
