import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';



class LayoutScreen extends StatelessWidget {
   LayoutScreen({Key? key}) : super(key: key);

   TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit,GeneralStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var cubit=GeneralCubit.get(context);
        return Scaffold(
          body:cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 20,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items:cubit.bottomNavBarItem,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNAvIndex(index);
            },
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
          ),
          floatingActionButton: FloatingActionButton(
            child:const Icon(IconlyLight.home),
            backgroundColor:Theme.of(context).primaryColor,
            onPressed: ()
            {
              cubit.changeBottomNAvIndex(2);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
