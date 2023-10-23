part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangeIndex extends HomeState {}
class InitControllerState extends HomeState {}

class GetAccountLoadingState extends HomeState{}
class GetAccountSuccessState extends HomeState{}
class GetAccountErrorState extends   HomeState{}

class UpdateAccountLoadingState extends HomeState{}
class UpdateAccountSuccessState extends HomeState{}
class UpdateAccountErrorState extends   HomeState{}

class UpdatePassLoadingState extends HomeState{}
class UpdatePassSuccessState extends HomeState{}
class UpdatePassErrorState extends   HomeState{}


class GetBestSellerLoadingState extends HomeState{}
class GetBestSellerSuccessState extends HomeState{}
class GetBestSellerErrorState extends   HomeState{}

class GetCategoriesLoadingState extends HomeState{}
class GetCategoriesSuccessState extends HomeState{}
class GetCategoriesErrorState extends   HomeState{}

class GetCategoriesDetailsLoadingState extends HomeState{}
class GetCategoriesDetailsSuccessState extends HomeState{}
class GetCategoriesDetailsErrorState extends   HomeState{}

class GetNewArrivalLoadingState extends HomeState {}
class GetNewArrivalSuccessState extends HomeState{}
class GetNewArrivalErrorState extends   HomeState{}

class GetSliderLoadingState extends HomeState{}
class GetSliderSuccessState extends HomeState{}
class GetSliderErrorState extends   HomeState{}

class AddCartLoadingState extends HomeState{}
class AddCartSuccessState extends HomeState{}
class AddCartErrorState extends   HomeState{}

class AddFavLoadingState extends HomeState{}
class AddFavSuccessState extends HomeState{}
class AddFavErrorState extends   HomeState{}

class RemoveFavLoadingState extends HomeState{}
class RemoveFavSuccessState extends HomeState{}
class RemoveFavErrorState extends   HomeState{}

class CartLoadingState extends HomeState{}
class CartSuccessState extends HomeState{}
class CartErrorState extends   HomeState{}

class UpdateCartLoadingState extends HomeState{}
class UpdateCartSuccessState extends HomeState{}
class UpdateCartErrorState extends   HomeState{}

class WishListLoadingState extends HomeState{}
class WishListSuccessState extends HomeState{}
class WishListErrorState extends   HomeState{}

class GetBooksLoadingState extends HomeState{}
class GetBooksSuccessState extends HomeState{}
class GetBooksErrorState extends   HomeState{}

class RemoveCartLoadingState extends HomeState{}
class RemoveCartSuccessState extends HomeState{}
class RemoveCartErrorState extends   HomeState{}

class cityState extends HomeState {}
class a extends HomeState {}

class GetCityLoadingState extends HomeState{}
class GetCitySuccessState extends HomeState{}
class GetCityErrorState extends   HomeState{}

class GetOrderHistoryLoadingState extends HomeState{}
class GetOrderHistorySuccessState extends HomeState{}
class GetOrderHistoryErrorState extends   HomeState{}

class GetSingleOrderHistoryLoadingState extends HomeState{}
class GetSingleOrderHistorySuccessState extends HomeState{}
class GetSingleOrderHistoryErrorState extends   HomeState{}

class SearchLoadingState extends HomeState{}
class SearchSuccessState extends HomeState{}
class SearchErrorState extends   HomeState{}

class PlaceOrderLoadingState extends HomeState{}
class PlaceOrderSuccessState extends HomeState{}
class PlaceOrderErrorState extends   HomeState{}

class GetLiveLoadingState extends HomeState{}
class GetLiveSuccessState extends HomeState{}
class GetLiveErrorState extends   HomeState{}

class fitter extends HomeState {}
class fitter1 extends HomeState {}
class fitter2 extends HomeState {}
class ClearFilterState extends HomeState {}