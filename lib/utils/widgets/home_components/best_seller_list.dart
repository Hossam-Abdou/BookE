import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';

import '../../../screens/home/view/details_screen.dart';
import '../../colors/custom_colors.dart';

class BestSellerList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = HomeCubit.get(context);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: cubit.bestSellerModel?.data?.products?.length ?? 0,
      separatorBuilder: (context, index) => SizedBox(
        width: 10.w,
      ),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                        id: cubit.bestSellerModel?.data
                            ?.products?[index]),
                  ));
            },
            child: Container(
              child: Stack(
                children: [
                  Image.network(
                    '${cubit.bestSellerModel!.data!.products![index].image}',
                    height: 150,
                  ),
                  Container(
                    color: CustomColors.primaryButton
                        .withOpacity(0.7),
                    width: 40.w,
                    height: 20.h,
                    child: Center(
                        child: Text(
                          '${cubit.bestSellerModel!.data!.products![index].discount}%',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              '${cubit.bestSellerModel!.data!.products![index].name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '${cubit.bestSellerModel!.data!.products![index].category}',
            style: GoogleFonts.roboto(color: Colors.grey[600]),
          ),
          Text(
            '${cubit.bestSellerModel!.data!.products![index].price}',
            style: GoogleFonts.roboto(
                decoration: TextDecoration.lineThrough,
                color: Colors.red[300],
                fontSize: 13),
          ),
          Text(
            '${cubit.bestSellerModel!.data!.products![index].priceAfterDiscount}',
            style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  },
);
  }
}
