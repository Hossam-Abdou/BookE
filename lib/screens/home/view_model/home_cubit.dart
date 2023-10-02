import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/screens/home/model/cart/remove_cart_model.dart';
import 'package:untitled4/screens/home/model/city_model.dart';
import 'package:untitled4/screens/home/model/favourite/add_fav_model.dart';
import 'package:untitled4/screens/home/model/favourite/fav_model.dart';
import 'package:untitled4/screens/home/model/home/best_seller_model.dart';
import 'package:untitled4/screens/home/model/home/categories_model.dart';
import 'package:untitled4/screens/home/model/home/new_arrival_model.dart';
import 'package:untitled4/screens/home/model/place_order_model.dart';
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
import '../model/order_history_model.dart';
import '../model/singleorderhistorymodel.dart';
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

  finalPrice(String price, String discount) {
    double finalPrice = double.parse(price) - (double.parse(price) * (double.parse(discount) / 100));
    return finalPrice.round();
  }
int index= 0;
  void getFilter(value)
  {
    index=value;
    emit(fitter());
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  initController() {
    emailController.text = userProfileModel?.data?.email ?? 'User email';
    nameController.text = userProfileModel?.data?.name ?? 'User name';
    addressController.text = userProfileModel?.data?.address ?? 'User address';
    phoneController.text = '${userProfileModel?.data?.phone ?? 'User phone'}';
    cityController.text = userProfileModel?.data?.city ?? 'City';
    emit(InitControllerState());
  }

  getAccount() async {
    emit(GetAccountLoadingState());
    await DioHelper.getData(
      url: EndPoints.profile,
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      print(await SecureStorage().storage.read(key: 'token'),);
      print('1');
      userProfileModel = UserProfileModel.fromJson(value.data);
      print('2');
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetAccountSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      print('3');
      if (error is DioException && error.response?.statusCode == 401) {
        print('5');
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetAccountErrorState());
    });
  }

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
  SingleOrderHistoryModel? singleOrderHistoryModel;
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

  CategoryDetailsModel? categoryDetailsModel;
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
      sliderModel = SliderModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetSliderSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetSliderErrorState());
    });
  }

  FavModel? wishListModel;

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

  CartModel? cartModel;

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
CityModel? cityModel;
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


  PlaceOrderModel? placeOrderModel;
  placeOrder() async {
    emit(AddCartLoadingState());
    await DioHelper.postData(
      url: EndPoints.placeOrder,
      data: {
        'governorate_id': 2,
        'phone':phoneController,
        'name':nameController,
        'email':emailController,
        'address':addressController
      },
    ).then((value) async {
      placeOrderModel = PlaceOrderModel.fromJson(value.data);
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(AddCartSuccessState());
        getCart();
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(AddCartErrorState());
    });
  }

  RemoveCartModel? removeCartModel;
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
      Icons.bookmarks_sharp,
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
