import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/presentation_layer/screens/create_post_screen.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';
import 'package:la_vie/presentation_layer/widgets/card_forums.dart';
import 'package:la_vie/presentation_layer/widgets/category.dart';

class ForumsScreen extends StatelessWidget {
   ForumsScreen({Key? key}) : super(key: key);

   TextEditingController searchController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var cubit=GeneralCubit.get(context);
        String token = CacheHelper.getData(key: 'token');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Discussion Forums',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),
            ),
            titleSpacing: 60,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconlyLight.arrow_left,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 45.0,
                    width: double.infinity,
                    color: const Color(0xffF8F8F8),
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
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 40.0,
                  width: 330,
                  child: selectCategoryOfForums(),
                ),
                const SizedBox(height: 10,),
                cubit.isLoadAllForums?const Center(child:CircularProgressIndicator(color:primaryColor,)):
                cardForums(token,context),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child:const Icon(Icons.add),
            mini: true,
            backgroundColor:Theme.of(context).primaryColor,
            onPressed: ()
            {
              navigatePushTo(
                  context: context,
                  navigateTo: CreatePostScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
