import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';
import 'package:la_vie/presentation_layer/widgets/my_card_details_favorite_screen.dart';

class MyCardScreen extends StatelessWidget {
   MyCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit,GeneralStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'My cart',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
            ),
            titleSpacing: 85,
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
          body:GeneralCubit.get(context).favorites!.isEmpty?Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                SizedBox(
                  height: 200,
                  width: 250,
                    child: Image.asset('assets/images/no_card.png')),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                    'Your cart is empty',
                  style: Theme.of(context).textTheme.bodyText2!.
                  copyWith(fontSize: 24,color:const Color(0xff212121),fontWeight:FontWeight.w700),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 260,
                  child: Text(
                    'Sorry, the keyword you entered cannot found, please check again or search with another keyword.',
                    style: Theme.of(context).textTheme.bodyText2!.
                    copyWith(fontSize: 18,fontWeight:FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ): Column(
            children:
            [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => myFavoriteCard(context,index),
                  separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                  itemCount:GeneralCubit.get(context).favorites!.length,
                ),
              ),
              Column(
                children:
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 10),
                    child: Row(
                      children:
                      [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.bodyText2!
                              .copyWith(fontSize: 20,color: Colors.grey[900],fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        GeneralCubit.get(context).favorites![0]['total']==null?const Text(''):
                        Text(
                          '${GeneralCubit.get(context).favorites![0]['total']} EGP',
                          style:GoogleFonts.inter(fontSize: 16.245,color: primaryColor,fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 43.0,
                    width: 280.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Checkout',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
