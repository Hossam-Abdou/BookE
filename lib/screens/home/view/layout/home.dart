import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled4/screens/authenticate/view/login_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view/details_screen.dart';
import 'package:untitled4/screens/home/view/layout/account.dart';
import 'package:untitled4/screens/home/view/layout/favourite_screen.dart';
import 'package:untitled4/utils/widgets/navigate.dart';

import '../../../../utils/colors/custom_colors.dart';
import '../../view_model/home_cubit.dart';
import '../categories_details.dart';
import '../order_history_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

        return Scaffold(
          key: drawerKey,
          drawer: NavigationDrawer(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPictureSize: Size(95, 88),
                  decoration: BoxDecoration(
                    color: Color(0xff2f0569)
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('${cubit.userProfileModel?.data?.image}'),),
                  accountName: Text('${cubit.userProfileModel?.data?.name}'),
                  accountEmail: Text('${cubit.userProfileModel?.data?.email}'),),
              ListTile(
                  leading: Icon(Icons.category_outlined),
                  title: Text(
                    'Order History',
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderHistoryScreen(),
                      ),),),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if(state is UserLogoutSuccessState)
                    {
                      pushReplace(context, LoginScreen());
                    }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      AuthCubit.get(context).LogOut();
                    },
                    child: ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text(
                          'Log Out',
                        ),
                        ),
                  );
                },
              ),
              new Divider(
                color: Colors.black38,
              ),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Color(0xff2f0569),
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                drawerKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.notes_outlined),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${cubit.userProfileModel?.data?.name} ',
                  style: GoogleFonts.roboto(
                      fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'What are you reading today ? ',
                  style: GoogleFonts.roboto(
                      fontSize: 15.sp, color: Colors.grey[300]),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: InkWell(
                  onTap: ()
                  {
                    pushNavigate(context, AccountScreen());
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage('${cubit.userProfileModel?.data?.image}'),
                    radius: 21.r,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConditionalBuilder(
                    condition: cubit.sliderModel != null,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    builder: (context) => CarouselSlider(
                        items: cubit.sliderModel?.data?.sliders
                            ?.map((e) => Image(
                                  image: NetworkImage('${e.image}'),
                                  width: double.infinity,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 150.0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayCurve: accelerateEasing,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Best Sellers', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 210.h,
                    child:cubit.bestSellerModel?.data?.products?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,

                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    Container(
                                      height: 100.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                                itemCount: 10, // Number of shimmer placeholders
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):
                    ListView.separated(
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
                                    )),
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
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Categories', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 155.h,
                    child: cubit.categoriesModel?.data?.categories?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,

                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  height: 100.0,
                                  color: Colors.black,
                                  // Placeholder widget to show shimmer effect
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                                itemCount: 4, // Number of shimmer placeholders
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        :
                    ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          cubit.categoriesModel?.data?.categories?.length ?? 0,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      itemBuilder: (context, index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.getCategoryDetails(cubit.categoriesModel
                                  ?.data?.categories?[index].id);
                              pushNavigate(
                                  context,
                                  CategoriesDetailsScreen(
                                    id: cubit.categoriesModel?.data
                                        ?.categories?[index].id,
                                  ));
                            },
                            child: Container(
                              child: Image.network(
                                'https://img.freepik.com/free-vector/books-stack-realistic_1284-4735.jpg',
                                height: 150,
                              ),
                            ),
                          ),
                          Text(
                              '${cubit.categoriesModel!.data!.categories![index].name}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('New Arrival', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 210.h,
                    child: cubit.newArrivalModel?.data?.products?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,

                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  height: 100.0,
                                  color: Colors.black,
                                  // Placeholder widget to show shimmer effect
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                                itemCount: 10, // Number of shimmer placeholders
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):ListView.separated(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
