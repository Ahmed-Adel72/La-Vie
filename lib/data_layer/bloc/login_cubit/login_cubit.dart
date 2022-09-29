import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/data_layer/dio/dio_exceptions.dart';
import 'package:la_vie/presentation_layer/layout/layout_screen.dart';
import 'package:la_vie/presentation_layer/models/login_model.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginStates());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoginLoading = false;
  UserLoginModel? userLoginModel;
  void userLogin({
    required String? email,
    required String? password,
    required BuildContext context,
  }) {
    emit(UserLoginLoadingState());
    isLoginLoading = true;
    DioHelper.postData(url: login, data: {
      'password': password!,
      'email': email!,
    }).then((value) {
      userLoginModel = UserLoginModel.fromJson(value.data);
      token=UserLoginModel.token;
      CacheHelper.setData(key: 'token', value: UserLoginModel.token).then((value)
      {
        GeneralCubit.get(context).getAllProducts(token: token);
        GeneralCubit.get(context).getAllBlogs(token: token);
        GeneralCubit.get(context).getAllForums(token: token);
        GeneralCubit.get(context).getMyData(token: token);
      }).then((value)
      {
        navigatePushAndFinish(context: context, navigateTo: LayoutScreen());
      });
      print(UserLoginModel.token);
      emit(UserLoginSuccessState());
      isLoginLoading = false;
      showToast(
          message: UserLoginModel.message!, toastState: ToastState.success);
    }).catchError((onError) {
      if(onError is DioError)
      {
        final errorMessage=DioExceptions.fromDioError(onError).toString();
        isLoginLoading = false;
        showToast(message: errorMessage, toastState: ToastState.error);
        emit(UserLoginErrorState());
      }
    });
  }

  bool isSignUpLoading = false;
  void userSignUp({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? password,
    required BuildContext context,
  }) {
    emit(UserSignUpLoadingState());
    isSignUpLoading = true;
    DioHelper.postData(url: signUp, data: {
      'firstName': firstName!,
      'lastName': lastName!,
      'email': email!,
      'password': password!,
    }).then((value) {
      userLoginModel = UserLoginModel.fromJson(value.data);
      token=UserLoginModel.token;
      CacheHelper.setData(key: 'token', value: UserLoginModel.token).then((value)
      {
        GeneralCubit.get(context).getAllProducts(token: token);
        GeneralCubit.get(context).getAllBlogs(token: token);
        GeneralCubit.get(context).getAllForums(token: token);
        GeneralCubit.get(context).getMyData(token: token);
      }).then((value)
      {
        navigatePushAndFinish(context: context, navigateTo: LayoutScreen());
      });
      print(UserLoginModel.token);
      emit(UserSignUpSuccessState());
      isSignUpLoading = false;
      showToast(
          message: UserLoginModel.message!, toastState: ToastState.success);
    }).catchError((onError) {
      if(onError is DioError)
      {
        isSignUpLoading = false;
        showToast(message: onError.response!.data['message'].toString(), toastState: ToastState.error);
        emit(UserSignUpErrorState());
      }
    });
  }

  bool isSignGoogleLoading = false;
  void userSignInWithGoogle({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? id,
    required String? picture,
    required BuildContext context,
  }) {
    emit(UserSignGoogleLoadingState());
    isSignGoogleLoading = true;
    DioHelper.postData(url: signGoogle, data: {
      'id': id!,
      'firstName': firstName!,
      'lastName': lastName!,
      'email': email!,
      'picture': picture!,
    }).then((value) {
      userLoginModel = UserLoginModel.fromJson(value.data);
      token=UserLoginModel.token;
      CacheHelper.setData(key: 'token', value: UserLoginModel.token).then((value)
      {
        GeneralCubit.get(context).getAllProducts(token: token);
        GeneralCubit.get(context).getAllBlogs(token: token);
        GeneralCubit.get(context).getAllForums(token: token);
        GeneralCubit.get(context).getMyData(token: token);
      }).then((value)
      {
        navigatePushAndFinish(context: context, navigateTo: LayoutScreen());
      });
      emit(UserSignGoogleSuccessState());
      isSignGoogleLoading = false;
      showToast(
          message: UserLoginModel.message!, toastState: ToastState.success);
    }).catchError((onError) {
      if(onError is DioError)
      {
        isSignGoogleLoading = false;
        showToast(message: onError.response!.data['message'].toString(), toastState: ToastState.error);
        emit(UserSignGoogleErrorState());
      }
    });
  }


  static final googleSignIn = GoogleSignIn();
  Future signIn() async {
    return googleSignIn.signIn();
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilityLoginIn() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityLoginInState());
  }

  bool isPasswordSign = true;
  IconData suffixSign = Icons.visibility_outlined;
  void changePasswordVisibilitySignUp() {
    isPasswordSign = !isPasswordSign;
    suffixSign =
    isPasswordSign ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilitySignUpInState());
  }

}
