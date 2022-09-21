import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
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
      CachHelper.setData(key: 'token', value: UserLoginModel.token).then((value)
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
    }).catchError((error) {
      emit(UserLoginErrorState());
      print(error);

      isLoginLoading = false;
      showToast(message: UserLoginModel.message!, toastState: ToastState.error);
    });
  }
}
