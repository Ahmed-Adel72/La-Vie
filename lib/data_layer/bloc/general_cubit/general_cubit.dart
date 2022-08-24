import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/presentation_layer/models/all_product.dart';
import 'package:la_vie/presentation_layer/models/get_my_data.dart';
import 'package:la_vie/presentation_layer/screens/home_screen.dart';
import 'package:la_vie/presentation_layer/screens/notification_screen.dart';
import 'package:la_vie/presentation_layer/screens/profile_screen.dart';
import 'package:la_vie/presentation_layer/screens/scan_screen.dart';
import 'package:la_vie/presentation_layer/screens/tree_screen.dart';
import 'package:la_vie/presentation_layer/shared/constants/constants.dart';

class GeneralCubit extends Cubit<GeneralStates>{
  GeneralCubit() : super(InitialState());

  static GeneralCubit get(context)=> BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavBarItem=const
  [
     BottomNavigationBarItem(
        icon:Icon(Icons.pets),
       label: 'tree',

    ),
     BottomNavigationBarItem(
        icon:Icon(IconlyLight.scan),
       label: 'scan',
    ),
     BottomNavigationBarItem(
        icon:Icon(IconlyLight.home,color: Colors.white,),
       label: 'scan',
    ),
     BottomNavigationBarItem(
        icon:Icon(IconlyLight.notification),
       label: 'Notification',
    ),
     BottomNavigationBarItem(
        icon:Icon(IconlyLight.profile),
       label: 'profile',
    ),
  ];

  List<Widget> screen=
  [
    TreeScreen(),
    ScanScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 2;
  void changeBottomNAvIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  /////get my data
  bool isLoadProfile=false;
  void getMyData({
    required String token,
  }) {
      isLoadProfile = true;
      emit(GetMyDataLoadingState());
      DioHelper.getData(
        url: getMe,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).then((value) {
        GetMyDataModel.getUserModel = Map<String, dynamic>.from(value.data);
        // isLoadProfile = false;
        emit(GetMyDataSuccessState());
        print(GetMyDataModel.email);
      }).catchError((error) {
        emit(GetMyDataErrorState());
      });
  }


  AllProductsData? allProductsData;
  void getAllProducts({
  required String token,
})
  {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: products,
      headers:
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }
    ).then((value)
    {
      allProductsData = AllProductsData.fromJson(value.data);
      print(value.data);
      emit(GetAllProductsSuccessState());
    }).catchError((error)
    {
      emit(GetAllProductsErrorState());
      print(error.toString());
    });
  }




}