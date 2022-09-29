import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/widgets/card_of_blogs.dart';
import 'package:la_vie/presentation_layer/widgets/category.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

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
              'Blogs',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),
            ),
            titleSpacing: 150,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Container(
                alignment: AlignmentDirectional.center,
                height: 40.0,
                width: 270,
                child: selectCategoryOfBlog(),
              ),
              const SizedBox(height: 10.0,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => cardBlogs(context,index),
                  separatorBuilder:(context, index) => const SizedBox(height: 10.0,),
                  itemCount:GeneralCubit.get(context).getLengthOfBlog(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
