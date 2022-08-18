import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/presentation_layer/models/login_model.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginStates());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoginLoading=false;
  UserLoginModel? userLoginModel;
  void userLogin({
    required String? email,
    required String? password,
    required BuildContext? context,
  })
  {
    emit(UserLoginLoadingStates());
    print("sss");
    isLoginLoading=true;
    DioHelper.postData(url: login,
        data:
        {
          'password':password!,
          'email':email!,
        }
        ).then((value)
    {
      userLoginModel=UserLoginModel.fromJson(value.data);
      token=UserLoginModel.token;
      emit(UserLoginSuccessStates());
      isLoginLoading=false;
      showToast(message:UserLoginModel.message!, toastState: ToastState.success );

    }).catchError((error)
    {
      emit(UserLoginErrorStates());
      print(error);

      isLoginLoading=false;
      showToast(message:UserLoginModel.message!, toastState: ToastState.error );

    });
  }

}
