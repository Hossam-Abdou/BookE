import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/screens/authenticate/view/board_screen.dart';
import 'package:untitled4/screens/authenticate/view/check_forget_password_screen.dart';
import 'package:untitled4/screens/authenticate/view/forget_password_screen.dart';
import 'package:untitled4/screens/authenticate/view/login_screen.dart';
import 'package:untitled4/screens/authenticate/view_model/authentication_cubit.dart';
import 'package:untitled4/screens/home/view_model/home_cubit.dart';
import 'package:untitled4/screens/home_screen.dart';
import 'package:untitled4/service/cache/secure_storage.dart';
import 'package:untitled4/service/dio_helper/dio_helper.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget? widget;

  String? token = await SecureStorage().storage.read(key: 'token');

  if (token != null) {
    widget = HomeScreen();
  } else {
    widget = OnboardScreen();
  }
  runApp(MyApp(startWidget:widget ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {


            return MultiBlocProvider(
               providers: [
                 BlocProvider(create: (context) => AuthCubit()),
                 BlocProvider(create: (context) =>
                 HomeCubit()
                   ..getAccount()
                   ..getBestSeller()
                   ..getCategories()
                   ..getNewArrival()
                     ..getSlider()
                   ..getWishList()
                     ..getCart()
                     ..getBooks()
                     ..getCity()
                     ..getOrderHistory()
                 )
               ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,

                home:AnimatedSplashScreen(
                  splash: Lottie.asset('images/splash.json',
                      width: 350.w, height: 200.h, fit: BoxFit.cover),
                  duration: 3500,
                  nextScreen:startWidget,
                  backgroundColor: Colors.white,
                  splashTransition: SplashTransition.slideTransition,
                  curve: Curves.bounceIn,

                ),
              ),
            );
        });
  }
}
