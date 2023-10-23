import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../screens/home/view/details_screen.dart';
import '../../../screens/home/view_model/home_cubit.dart';
import '../../colors/custom_colors.dart';

class NewArrivalList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    var cubit= HomeCubit.get(context);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount:
      cubit.newArrivalModel?.data?.products?.length ?? 0,
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
                        id: cubit.newArrivalModel?.data
                            ?.products?[index]),
                  ));
            },
            child: Container(
              child: Stack(
                children: [
                  Image.network(
                    '${cubit.newArrivalModel!.data!.products![index].image}',
                    height: 150,
                  ),
                  Container(
                    color: CustomColors.primaryButton
                        .withOpacity(0.6),
                    width: 40.w,
                    height: 20.h,
                    child: Center(
                        child: Text(
                          '${cubit.newArrivalModel!.data!.products![index].discount}%',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              '${cubit.newArrivalModel!.data!.products![index].name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '${cubit.newArrivalModel!.data!.products![index].category}',
            style: GoogleFonts.roboto(color: Colors.grey[600]),
          ),
          Text(
            '${cubit.newArrivalModel!.data!.products![index].price}',
            style: GoogleFonts.roboto(
                decoration: TextDecoration.lineThrough,
                color: Colors.red[300],
                fontSize: 13),
          ),
          Text(
            '${cubit.newArrivalModel!.data!.products![index].priceAfterDiscount}',
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
