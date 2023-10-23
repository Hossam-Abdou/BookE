import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service/cache/secure_storage.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../utils/end_points/urls.dart';
import '../model/authentication_model.dart';
import '../model/verify_email_model.dart';
part 'authentication_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController verifyyPasswordController = TextEditingController();
  TextEditingController cverifyPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var regKey = GlobalKey<FormState>();

  var updatKey = GlobalKey<FormState>();
  var resetKey = GlobalKey<FormState>();
  var updatePassKey = GlobalKey<FormState>();


  AuthenticateModel? authenticateModel;
  VerifyModel? verifyModel;

String? email;
  Register() async {
    emit(UserRegisterLoadingState());
    await DioHelper.postData(url: EndPoints.register, data: {
      "email": emailController.text,
      "password": passwordController.text,
      "name": nameController.text,
      "password_confirmation": confirmController.text,
    }).then((value) async {
      print(value.data);
      authenticateModel = AuthenticateModel.fromJson(value.data);
      if (authenticateModel!.status == 200) {
        print(authenticateModel!.data!.token);
        emit(UserRegisterSuccessState());
      }
      await SecureStorage().storage.write(key: 'token', value: authenticateModel!.data!.token,);
      print(
          ' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(UserRegisterErrorState());
    });
  }

  Login() async {
    emit(UserLoginLoadingState());
    await DioHelper.postData(url: EndPoints.login, data: {
      "email": emailController.text,
      "password": passwordController.text,
    }).then((value) async {
      print(value.data);
      authenticateModel = AuthenticateModel.fromJson(value.data);
      if (authenticateModel!.status == 200) {
        print(authenticateModel!.data!.token);
        emit(UserLoginSuccessState());
      }
      await SecureStorage().storage.write(key: 'token', value: authenticateModel!.data!.token);
      print(' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UserLoginErrorState());
    });
  }
  LogOut() async {
    emit(UserLogoutLoadingState());
    await DioHelper.postData(
        url: EndPoints.logOut,
      token:await SecureStorage().storage.read(key:'token'),
       ).then((value) async {
         print('1');
      print(value.data);
      if (value.statusCode == 200) {
        print(value.data['message']);
        emit(UserLogoutSuccessState());
        print(' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
      }
      await SecureStorage().storage.delete(key: 'token');
      print(' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
    }).catchError((error) {
      print('122');
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UserLogoutErrorState());
    });
  }

  verifyEmail() async {
    emit(VerifyEmailLoadingState());
    DioHelper.postData(url: EndPoints.verify,
        token: await SecureStorage().storage.read(key: 'token'),
        data: {
      "verify_code": int.parse(pinController.text),
    }).then((value) async {
      print(value.data);
      if (value.data['status'] == 200 ||value.data['status'] == 201 ) {
        emit(VerifyEmailSuccessState());
      }
      print(' The token is:  ${await SecureStorage().storage.read(key: 'token')}');
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(VerifyEmailErrorState());
    });
  }

  resendVerifyEmail() async {
    emit(ResendVerifyEmailLoadingState());
    await DioHelper.getData(url: EndPoints.resend,
        token: await SecureStorage().storage.read(key: 'token'),
     ).then((value) async {
      if (value.data['status'] == 200 ||value.data['status'] == 201 ) {
        emit(ResendVerifyEmailSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(ResendVerifyEmailErrorState());
    });
  }

  sendForgetPass() async {
    emit(SendForgetPassLoadingState());
    await DioHelper.postData(url: EndPoints.sendForget,
        data: {
      'email':emailController.text,
        },
        token: await SecureStorage().storage.read(key: 'token'),
     ).then((value) async {
      if (value.data['status'] == 200 ||value.data['status'] == 201 ) {
        emit(SendForgetPassSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 404) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(SendForgetPassErrorState());
    });
  }

  checkForgetPass() async {
    emit(CheckForgetPassLoadingState());
    await DioHelper.postData(url: EndPoints.checkForgetPassword,
        data: {
      'verify_code':verifyPasswordController.text,
        },
        token: await SecureStorage().storage.read(key: 'token'),
     ).then((value) async {
      if (value.data['status'] == 200 ||value.data['status'] == 201 ) {
        emit(CheckForgetPassSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(CheckForgetPassErrorState());
    });
  }

  resetPassword() async {
    emit(ResetPassLoadingState());
    await DioHelper.postData(
      url: EndPoints.resetPassword,
      data: {
        'verify_code': verifyyPasswordController.text,
        'new_password': newPasswordController.text,
        'new_password_confirmation': confirmNewPasswordController.text,
      },
      token: await SecureStorage().storage.read(key: 'token'),
    ).then((value) async {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(ResetPassSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 422) {
        final data = error.response?.data;
        final message = data['errors'];
        print(message);
      }
      emit(ResetPassErrorState());
    });
  }


  int selectedCheckbox = 0;

  void updateRadioValue(value) {
    selectedCheckbox = value;
    emit(RadioValueChanged());
  }

  bool authenticateCheckBox = false;

  void changeCheck() {
    authenticateCheckBox = !authenticateCheckBox;
    emit(CheckBoxChangeState());
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
    confirmController.clear();
    nameController.clear();
    emit(ClearControllerState());
  }

  var boardController = PageController();



  void onBoardChange(index) {
    if (index == board.length - 1) {
      isLast = true;
    } else {
      isLast = false;
    }
  }
  bool isLast = false;

  List<bording> board = [
    bording(
        title: 'Welcome Screen ',
        image: 'images/board.json',
        body:
        'Discover the Power of Book Shop Description: Books shop is a powerful and user-friendly app that helps you. Get ready to explore its amazing features and enhance your'),
    bording(
        title: ' Easy to Use',
        image: 'images/board3.json',
        body:'Intuitive Interface Description: With Books Shop, you can easily find books Our app provides a seamless and intuitive user interface.'
    ),
    bording(
        title: 'Get Started',
        image: 'images/board4.json',
        body: 'Book Shop keeps you connected and informed in real time. Receive instant notifications, updates, and alerts so you never miss out , Stay in control and optimize your experience.'),
  ];
}

class bording {
  String? title;
  dynamic image;
  String? body;

  bording({required this.title, required this.image, required this.body});
}
