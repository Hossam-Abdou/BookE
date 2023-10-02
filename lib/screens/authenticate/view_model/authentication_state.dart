part of 'authentication_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginModelInitial extends AuthState {}
class to extends AuthState {}

class UserLoginSuccessState extends AuthState{}
class UserLoginErrorState extends AuthState{}
class UserLoginLoadingState extends AuthState{}


class UserLogoutLoadingState extends AuthState{}
class UserLogoutSuccessState extends AuthState{}
class UserLogoutErrorState extends AuthState{}

class UserRegisterSuccessState extends AuthState{}
class UserRegisterErrorState extends AuthState{}
class UserRegisterLoadingState extends AuthState{}

class UserUpdateSuccessState extends AuthState{}
class UserUpdateErrorState extends AuthState{}
class UserUpdateLoadingState extends AuthState{}

class VerifyEmailSuccessState extends AuthState{}
class VerifyEmailErrorState extends AuthState{}
class VerifyEmailLoadingState extends AuthState{}

class ResendVerifyEmailSuccessState extends AuthState{}
class ResendVerifyEmailErrorState extends AuthState{}
class ResendVerifyEmailLoadingState extends AuthState{}

class SendForgetPassSuccessState extends AuthState{}
class SendForgetPassErrorState extends AuthState{}
class SendForgetPassLoadingState extends AuthState{}






class RadioValueChanged extends AuthState{}
class CheckBoxChangeState extends AuthState{}

class GetUserDetailsSucceess extends AuthState{}
class GetUserDetailsError extends AuthState{}

class ClearControllerState extends AuthState{}


