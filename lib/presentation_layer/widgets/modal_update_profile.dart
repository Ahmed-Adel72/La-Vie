import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';

Widget modalSheetUpdate(
    {required BuildContext context,
      required String nameOfModal,
      required String labelText,
      required Icon prefixIcon,
      required TextEditingController controller,
      required TextEditingController controllerFirstName,
      required TextEditingController controllerLastName,
      required TextEditingController controllerEmail,}) {
  return BlocConsumer<GeneralCubit, GeneralStates>(
    listener: (context, state){},
    builder: (context, state)
    {
      String token=CacheHelper.getData(key: 'token');
      var cubit=GeneralCubit.get(context);
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  nameOfModal,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700,color: Colors.grey[800]),
                ),
                const SizedBox(
                  height: 28.0,
                ),
                SizedBox(
                  width: 322.0,
                  child: defaultTextFormField(
                      context: context,
                      controller: controller,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: labelText,
                      prefixIcon:prefixIcon,
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      radius: 10,
                      onChanged: (value) {},
                      onSubmit: (value) {},
                ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                cubit.isUpdateProfile?const Center(child:CircularProgressIndicator(color:primaryColor,)):
                SizedBox(
                  width: 322.0,
                  height: 45.0,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                    ),
                    onPressed: ()
                    {
                        cubit.updateMyData(
                          token: token,
                          firstName: controllerFirstName.text,
                          lastName: controllerLastName.text,
                          email: controllerEmail.text,
                        );
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
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