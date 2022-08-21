import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_cubit.dart';
import 'package:la_vie/data_layer/dio/dio.dart';
import 'package:la_vie/presentation_layer/layout/layout_screen.dart';
import 'data_layer/bloc/bloc_observer/bloc_observer.dart';
import 'data_layer/bloc/general_cubit/general_cubit.dart';
import 'data_layer/bloc/login_cubit/login_states.dart';
import 'data_layer/bloc/sign_up_cubit/sign_up_cubit.dart';
import 'presentation_layer/screens/profile_screen.dart';
import 'presentation_layer/shared/theme/theme_data.dart';


void main() async{
  runApp(const MyApp());
  DioHelper.init();

  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context)=> GeneralCubit(),),
        BlocProvider(
            create: (context)=> LoginCubit(),),
        BlocProvider(
            create: (context)=> SignUpCubit(),),
      ],
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'La Vie',
            theme: lightMode,
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}
