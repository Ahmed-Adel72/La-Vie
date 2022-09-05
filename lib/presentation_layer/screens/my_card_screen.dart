import 'package:flutter/cupertino.dart';
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
          body:GeneralCubit.get(context).favorites.isEmpty?Container(
            alignment: AlignmentDirectional.center,
            height: 200.0,
            width: 300,
            child: Image.asset('assets/images/no_card.png'),
          ): Column(
            children:
            [
              Container(
                height: 460,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => MyFavoriteCard(context,index),
                  separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                  itemCount:GeneralCubit.get(context).favorites.length,
                ),
              ),
              Column(
                children:
                [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children:
                      [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.bodyText2!
                              .copyWith(fontSize: 18,color: Colors.grey[800]),
                        ),
                        const Spacer(),
                        Text(
                          '180,000 EGP',
                          style:GoogleFonts.inter(fontSize: 16,color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
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
