import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:untitled4/screens/home/model/cart/remove_cart_model.dart';
import 'package:untitled4/screens/home/model/city_model.dart';
import 'package:untitled4/screens/home/model/favourite/add_fav_model.dart';
import 'package:untitled4/screens/home/model/favourite/fav_model.dart';
import 'package:untitled4/screens/home/model/home/best_seller_model.dart';
import 'package:untitled4/screens/home/model/home/categories_model.dart';
import 'package:untitled4/screens/home/model/home/new_arrival_model.dart';
import 'package:untitled4/screens/home/model/order/place_order_model.dart';
import 'package:untitled4/screens/home/model/slider_model.dart';
import 'package:untitled4/screens/home/view/layout/account.dart';
import 'package:untitled4/screens/home/view/layout/books_screen.dart';
import 'package:untitled4/screens/home/view/layout/cart_screen.dart';
import 'package:untitled4/screens/home/view/layout/favourite_screen.dart';
import '../../../service/cache/secure_storage.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../utils/end_points/urls.dart';
import '../../authenticate/model/user_profile.dart';
import '../model/cart/add_cart_model.dart';
import '../model/books_model.dart';
import '../model/cart/cart_model.dart';
import '../model/category_detail_model.dart';
import '../model/order/order_history_model.dart';
import '../model/order/singleorderhistorymodel.dart';
import '../model/search_model.dart';
import '../view/layout/home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserProfileModel? userProfileModel;
  BestSellerModel? bestSellerModel;
  CategoriesModel? categoriesModel;
  NewArrivalModel? newArrivalModel;
  SliderModel? sliderModel;
  AddCartModel? addCartModel;
  AddFavModel? addFavModel;
  BooksModel? booksModel;
  OrderHistoryModel? orderHistoryModel;
  SingleOrderHistoryModel? singleOrderHistoryModel;
  CategoryDetailsModel? categoryDetailsModel;
  FavModel? wishListModel;
  CartModel? cartModel;
  CityModel? cityModel;
  PlaceOrderModel? placeOrderModel;
  RemoveCartModel? removeCartModel;



int index= 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  var updatePassKey = GlobalKey<FormState>();
  var searchKey = GlobalKey<FormState>();

  final ScreenshotController screenshotController = ScreenshotController();


  Future<void> takeScreenshotAndSave() async {
    final Uint8List? screenshot = await screenshotController.capture();
    await Future.delayed(Duration(milliseconds: 2000));
    final result = await ImageGallerySaver.saveImage(screenshot!);

    print("File Saved to Gallery");
    emit(a());
  }

  finalPrice(String price, String discount) {
    double finalPrice = double.parse(price) - (double.parse(price) * (double.parse(discount) / 100));
    return finalPrice.round();
  }

  // user account page
  getAccount() async {
    emit(GetAccountLoadingState());
    await DioHelper.getData(
      url: EndPoints.profile,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      userProfileModel = UserProfileModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetAccountSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetAccountErrorState());
    });
  }
  initController() {
    emailController.text = userProfileModel?.data?.email ?? 'User email';
    nameController.text = userProfileModel?.data?.name ?? 'User name';
    addressController.text = userProfileModel?.data?.address ?? 'User address';
    phoneController.text = '${userProfileModel?.data?.phone ?? 'User phone'}';
    cityController.text = userProfileModel?.data?.city ?? 'City';
    emit(InitControllerState());
  }
  updateProfile() async {
    emit(UpdateAccountLoadingState());
    await DioHelper.postData(
      url: EndPoints.updateProfile,
      data: {
        'phone':phoneController.text,
        'name':nameController.text,
        'address':addressController.text,
        'city':cityController.text,
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(UpdateAccountSuccessState());
        getAccount();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(UpdateAccountErrorState());
    });
  }
  updatePass() async {
    emit(UpdatePassLoadingState());
    await DioHelper.postData(
      url: EndPoints.updatePass,
      data: {
        'current_password': passwordController.text,
        'new_password': newPasswordController.text,
        'new_password_confirmation': confirmNewPasswordController.text,
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(UpdatePassSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(UpdatePassErrorState());
    });
  }


  // home page
  getBestSeller() async {
    emit(GetBestSellerLoadingState());
    await DioHelper.getData(
      url: EndPoints.bestSeller,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      bestSellerModel = BestSellerModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetBestSellerSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetBestSellerErrorState());
    });
  }

  getCategories() async {
    emit(GetCategoriesLoadingState());
    await DioHelper.getData(
      url: EndPoints.categories,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      categoriesModel = CategoriesModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetCategoriesSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetCategoriesErrorState());
    });
  }

  getNewArrival() async {
    emit(GetNewArrivalLoadingState());
    await DioHelper.getData(
      url: EndPoints.newArrival,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      newArrivalModel = NewArrivalModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetNewArrivalSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetNewArrivalErrorState());
    });
  }

  getSlider() async {
    emit(GetSliderLoadingState());
    await DioHelper.getData(
      url: EndPoints.slider,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print('1');
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        print('2');
        sliderModel = SliderModel.fromJson(value.data);
        emit(GetSliderSuccessState());
      }
    }).catchError((error) {
      print('3');
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetSliderErrorState());
    });
  }

  getCategoryDetails(id) async {
    emit(GetCategoriesDetailsLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.categories}/$id',
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetCategoriesDetailsSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetCategoriesDetailsErrorState());
    });
  }



  // order
  getOrderHistory() async {
    emit(GetOrderHistoryLoadingState());
    await DioHelper.getData(
      url: EndPoints.orderHistory,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      orderHistoryModel = OrderHistoryModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetOrderHistorySuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetOrderHistoryErrorState());
    });
  }

  getSingleOrderHistory(id) async {
    emit(GetSingleOrderHistoryLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.singleOrderHistory}/$id',
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      singleOrderHistoryModel = SingleOrderHistoryModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetSingleOrderHistorySuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetSingleOrderHistoryErrorState());
    });
  }

  // favourite
  getWishList() async {
    emit(WishListLoadingState());
    await DioHelper.getData(
      url: EndPoints.wishList,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        wishListModel = FavModel.fromJson(value.data);
        emit(WishListSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(WishListErrorState());
    });
  }
  addToFav({required int id}) async {
    emit(AddFavLoadingState());
    await DioHelper.postData(
      url: EndPoints.addFav,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addFavModel = AddFavModel
          .fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(AddFavSuccessState());
        getWishList();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(AddFavErrorState());
    });
  }
  removeFav({required int id}) async {
    emit(RemoveFavLoadingState());
    await DioHelper.postData(
      url: EndPoints.removeFav,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addFavModel = AddFavModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(RemoveFavSuccessState());
        getWishList();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(RemoveFavErrorState());
    });
  }

  // Cart screen

  addToCart({required int id}) async {
    emit(AddCartLoadingState());
    await DioHelper.postData(
      url: EndPoints.addCart,
      data: {'product_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addCartModel = AddCartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(AddCartSuccessState());
        getCart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(AddCartErrorState());
    });
  }
  getCart() async {
    emit(CartLoadingState());
    await DioHelper.getData(
      url: EndPoints.cart,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      cartModel = CartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(CartSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(CartErrorState());
    });
  }
  removeCart({required  int id}) async {
    emit(RemoveCartLoadingState());
    await DioHelper.postData(
      url: EndPoints.removeCart,
      data: {'cart_item_id': id},
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print(value.data['message']);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        print('2');
        removeCartModel = RemoveCartModel.fromJson(value.data);
        print('5');
        emit(RemoveCartSuccessState());
        getCart();

      }
    }).catchError((error) {
      print('3');
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422 || error.response?.statusCode == 401) {
        print('4');
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(RemoveCartErrorState());
    });
  }
  updateCart({required int id,required int quantity}) async {
    emit(UpdateCartLoadingState());
    await DioHelper.postData(
      url: EndPoints.updateCart,
      data: {
        'cart_item_id': id,
        'quantity':quantity

      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      addCartModel = AddCartModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(UpdateCartSuccessState());
        getCart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(UpdateCartErrorState());
    });
  }

  // books screen
  getBooks() async {
    emit(GetBooksLoadingState());
    await DioHelper.getData(
      url: EndPoints.getBooks,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      booksModel = BooksModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetBooksSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetBooksErrorState());
    });
  }
  // place order
  getCity() async {
    emit(GetCityLoadingState());
    await DioHelper.getData(
      url: EndPoints.city,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      cityModel = CityModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetCitySuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetCityErrorState());
    });
  }

  void getCities(value) {
    index=value;
    emit(cityState());
  }

  placeOrder() async {
    emit(PlaceOrderLoadingState());
    await DioHelper.postData(
      url: EndPoints.placeOrder,
      data: {
        'governorate_id': index,
        'phone':phoneController.text,
        'name':nameController.text,
        'email':emailController.text,
        'address':addressController.text
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      placeOrderModel = PlaceOrderModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(PlaceOrderSuccessState());
        getOrderHistory();
        getCart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(PlaceOrderErrorState());
    });
  }

  SearchModel? searchModel;
   searchBooks(text) async {
    emit(SearchLoadingState());
    await DioHelper.getData(
        url: EndPoints.search,
        query: {
          'name': '$text'
        },
        token: await SecureStorage().storage.read(key: 'token'))
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(SearchErrorState());
    });
  }


  int currentindex = 0;

  void changecurrentindex(index) {
    currentindex = index;
    emit(ChangeIndex());
  }

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.book,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.shopping_cart,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite_border_outlined,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 30.sp,
      color: Colors.white,
    ),
  ];

  List<Widget> layouts = [
    Home(),
    BooksScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen()
  ];
}
