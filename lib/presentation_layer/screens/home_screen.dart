import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/layout/layout_screen.dart';
import 'package:la_vie/presentation_layer/widgets/card_details_tree.dart';

import '../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit,GeneralStates>(
      listener: (context,state){},
      builder: (context, state)
      {
        var cubit=GeneralCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: SizedBox(
                    width: 400,
                    height: 35.0,
                    child: Image.asset('assets/images/la_vie.png'),
                  ),
                ),
                const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45.0,
                          width: 280.0,
                          color:  const Color(0xffF8F8F8),
                          child: TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: 'search',
                              labelStyle: Theme.of(context).textTheme.bodyText2!,
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Theme.of(context).primaryColor,
                              iconColor: Theme.of(context).primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color:  Color(0xffF8F8F8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: 40.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Row(
                        children:
                        [
                          Container(
                            height: 30.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:Center(
                                child: Text('seeds',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!,)),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
                      itemCount: 10,
                    ),
                  ),
                ),
                cardDetailsTree(),
              ],
            ),
          ),
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
            mini: true,
            child:const Icon(Icons.home),
            backgroundColor:Theme.of(context).primaryColor,
            onPressed: ()
            {
              navigatePushAndFinish(
                context: context,
                navigateTo: HomeScreen(),
              );

            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
