import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Create New Post',
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              const Icon(
                                  Icons.add,
                                  color: primaryColor,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                  'Add photo',
                                style: Theme.of(context).textTheme.bodyText2!
                                .copyWith(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: TextFormField(
                      controller: titleController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      controller: descriptionController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Container(
                    height: 45.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: ()
                      {

                      },
                      child: Text(
                        'Post',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
