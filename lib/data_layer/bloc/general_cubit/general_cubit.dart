import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/layout/layout_screen.dart';
import 'package:la_vie/presentation_layer/screens/notification_screen.dart';
import 'package:la_vie/presentation_layer/screens/profile_screen.dart';
import 'package:la_vie/presentation_layer/screens/scan_screen.dart';
import 'package:la_vie/presentation_layer/screens/tree_screen.dart';

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
        icon:Icon(Icons.settings_overscan),
       label: 'scan',
    ),
     BottomNavigationBarItem(
        icon:Icon(Icons.notifications_none_outlined),
       label: 'Notification',
    ),
     BottomNavigationBarItem(
        icon:Icon(Icons.account_circle_outlined),
       label: 'profile',
    ),
  ];

  List<Widget> screen=
  [
    TreeScreen(),
    ScanScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;
  void changeBottomNAvIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }


}