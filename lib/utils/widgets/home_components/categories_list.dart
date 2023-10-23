import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';

import '../../../screens/home/view/single_category_screen.dart';
import '../navigate.dart';

class CategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit= HomeCubit.get(context);
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: cubit.categoriesModel?.data?.categories?.length ?? 0,
          separatorBuilder: (context, index) =>
              SizedBox(
                width: 10.w,
              ),
          itemBuilder: (context, index) =>
              InkWell(
                onTap: () {
                  cubit.getCategoryDetails(cubit.categoriesModel
                      ?.data?.categories?[index].id);
                  pushNavigate(context, SingleCategoryScreen(
                        id: cubit.categoriesModel?.data
                            ?.categories?[index].id,
                      ));
                },
                child: Stack(
                  children: [

                    Container(
                      width: 145.w,
                      height: 140.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg',
                        ),
                      ),
                    ),

                    Container(
                      height: 150.h,
                      width: 145.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.3)),
                      alignment: Alignment.center,
                      child: Text(
                          '${cubit.categoriesModel!.data!.categories![index].name}'
                      ,style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }
}
