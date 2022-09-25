import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/presentation_layer/screens/forums_screen.dart';
import 'package:la_vie/presentation_layer/screens/my_card_screen.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';
import 'package:la_vie/presentation_layer/widgets/card_details_home_screen.dart';
import 'package:la_vie/presentation_layer/widgets/category.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        String token = CacheHelper.getData(key: 'token');
        var cubit = GeneralCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Row(
                  children:
                  [
                     Padding(
                      padding:const EdgeInsets.only(left: 8.0),
                      child:InkWell(
                        onTap: ()
                        {
                          navigatePushTo(context: context, navigateTo: ForumsScreen());
                        },
                        child:const SizedBox(
                          height: 30.0,
                            width: 30.0,
                            child:Icon(
                              Icons.wysiwyg_outlined,
                              color: primaryColor,
                            ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 100,),
                    SizedBox(
                      height: 35.0,
                      child: Image.asset('assets/images/la_vie.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45.0,
                          color: const Color(0xffF8F8F8),
                          child: TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: 'search',
                              labelStyle: Theme.of(context).textTheme.bodyText2!,
                              prefixIcon: const Icon(Icons.search,color:primaryColor,),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xffF8F8F8),
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
                    ),
                    InkWell(
                      onTap: ()
                      {
                        navigatePushTo(context: context, navigateTo: MyCardScreen());
                      },
                      child: Container(
                        height: 45.0,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child:const Icon(
                            IconlyBroken.buy,
                            color: Colors.white,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.only(left: 10.0,),
                child: SizedBox(
                  height: 40.0,
                  child: selectCategory(),
                ),
              ),
              cardDetailsTree(context),
            ],
          ),
        );
      },
    );
  }
}
