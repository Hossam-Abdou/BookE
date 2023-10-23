import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled4/screens/authenticate/view/login_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view/layout/account.dart';
import 'package:untitled4/screens/home/view/drawer/update_password_screen.dart';
import 'package:untitled4/utils/widgets/navigate.dart';
import '../../../../utils/colors/custom_colors.dart';
import '../../../../utils/widgets/home_components/best_seller_list.dart';
import '../../../../utils/widgets/home_components/categories_list.dart';
import '../../../../utils/widgets/home_components/new_arrival_list.dart';
import '../../../../utils/widgets/home_components/shimmer.dart';
import '../../view_model/home_cubit.dart';
import '../drawer/order_history_screen.dart';
import '../search_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
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
                    color: CustomColors.primaryButton,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('${cubit.userProfileModel?.data?.image}'),),
                  accountName: Text('${cubit.userProfileModel?.data?.name}'),
                  accountEmail: Text('${cubit.userProfileModel?.data?.email}'),),
              ListTile(
                  leading: Icon(Icons.history_sharp),
                  title: Text(
                    'Order History',
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OrderHistoryScreen(),
                      ),),),
              ListTile(
                  leading: Icon(Icons.system_update),
                  title: Text(
                    'Update Password',
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => UpdatePassScreen(),
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
              const Divider(
                color: Colors.black38,
              ),
            ],
          ),
          appBar: AppBar(
            backgroundColor:CustomColors.primaryButton,
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
                  'Hi, ${cubit.userProfileModel?.data?.name??'UserNam'} ',
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.manage_search_sharp),

              backgroundColor: CustomColors.primaryButton,
              mini: true,
              onPressed: (){
            pushNavigate(context, Searchscreen(),);
          }),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConditionalBuilder(
                    condition: cubit.sliderModel == null,
                    fallback: (context) => CarouselSlider(
                        items: cubit.sliderModel?.data?.sliders
                            ?.map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                        ),)
                            .toList(),
                        options: CarouselOptions(
                          height: 160.0.h,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayCurve: accelerateEasing,
                          scrollDirection: Axis.horizontal,
                        )),
                    builder: (context) => Center(child: CircularProgressIndicator(
                      color: CustomColors.primaryButton,
                    )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Best Sellers', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),

                  SizedBox(
                    height: 10.h,
                  ),
                  // best seller list and shimmer
                  SizedBox(
                    height: 228.h,
                    child:cubit.bestSellerModel?.data?.products?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: ShimmerScreen(),
                    ):
                    BestSellerList(),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  Text('Categories', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),

                  SizedBox(
                    height: 10.h,
                  ),

                  SizedBox(
                    height: 170.h,
                    child: cubit.categoriesModel?.data?.categories?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: ShimmerScreen(),
                    ) :
                    CategoriesList(),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  Text('New Arrival', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25.sp)),

                  SizedBox(
                    height: 10.h,
                  ),

                  SizedBox(
                    height: 226.h,
                    child: cubit.newArrivalModel?.data?.products?.length == null ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: ShimmerScreen(),
                    ):
                    NewArrivalList(),
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
