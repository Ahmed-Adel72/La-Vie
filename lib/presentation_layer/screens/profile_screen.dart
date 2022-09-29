import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/data_layer/cach_helper.dart';
import 'package:la_vie/presentation_layer/models/get_my_data.dart';
import 'package:la_vie/presentation_layer/screens/login_signup_screen.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';
import 'package:la_vie/presentation_layer/widgets/modal_update_profile.dart';

var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var emailController = TextEditingController();

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    firstNameController.text=GetMyDataModel.getFirstName();
    lastNameController.text=GetMyDataModel.getLastName();
    emailController.text=GetMyDataModel.getUserEmail();
    return BlocConsumer<GeneralCubit, GeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        String token=CacheHelper.getData(key: 'token');
        var cubit=GeneralCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children:
              [
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: double.infinity,
                  decoration:BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        GetMyDataModel.getUserPhoto()!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      IconButton(
                        splashRadius: 30,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title:const Text('Are You Sure'),
                                  content: Text(
                                    'Logout?',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            CacheHelper.deleteData(
                                              'token',
                                            ).then((value) {
                                              if (value)
                                              {
                                                navigatePushAndFinish(
                                                    context: context,
                                                    navigateTo: LoginScreen());
                                              }
                                            }).then((value) {
                                              token = '';
                                              cubit.favorites=[];
                                            });
                                          },
                                          child: Text(
                                            'Yes',
                                            style: Theme.of(context).textTheme.bodyText1,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: ()
                                          {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'No',
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                        icon:const Icon(
                          IconlyLight.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image:DecorationImage(
                              image: NetworkImage(
                                  GetMyDataModel.getUserPhoto()!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          GetMyDataModel.getFirstName()+' '+GetMyDataModel.getLastName(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.59,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              height: 50,
                              width: 290,
                              decoration: const BoxDecoration(
                                color: Color(0xffF3FEF1),
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage('assets/images/star.png')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'You have ${GetMyDataModel.getUserPoints()} points',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 20),
                            child: Container(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                'Edit Profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1D592C),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child:const Icon(Icons.sync_alt_outlined,size: 15,color: Colors.white,),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Change First Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: const Color(0xff2F2E2E),
                                          fontSize: 17),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          modalSheetUpdate(
                                            context: context,
                                            controller: firstNameController,
                                            controllerFirstName: firstNameController,
                                            controllerLastName: lastNameController,
                                            controllerEmail: emailController,
                                            nameOfModal: 'Change Your Name',
                                            labelText: 'Your first name',
                                            prefixIcon: const Icon(
                                            IconlyLight.user,
                                            color: Colors.grey,
                                           ),
                                          ),
                                    );
                                  },
                                  icon: const Icon(
                                    IconlyLight.arrow_right,
                                    color: Color(0xff1D592C),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1D592C),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child:const Icon(Icons.sync_alt_outlined,size: 15,color: Colors.white,),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Change Last Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      color: const Color(0xff2F2E2E),
                                      fontSize: 17),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    // cubit.getMyData(token: token);
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          modalSheetUpdate(
                                            context: context,
                                            controller: lastNameController,
                                            controllerFirstName: firstNameController,
                                            controllerLastName: lastNameController,
                                            controllerEmail: emailController,
                                            nameOfModal: 'Change Your Name',
                                            labelText: 'Your last name',
                                            prefixIcon: const Icon(
                                              IconlyLight.user,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    );
                                  },
                                  icon: const Icon(
                                    IconlyLight.arrow_right,
                                    color: Color(0xff1D592C),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1D592C),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child:const Icon(Icons.sync_alt_outlined,size: 15,color: Colors.white,),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Change Email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: const Color(0xff2F2E2E),
                                          fontSize: 17),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          modalSheetUpdate(
                                            context: context,
                                            controller: emailController,
                                            controllerFirstName: firstNameController,
                                            controllerLastName: lastNameController,
                                            controllerEmail: emailController,
                                            nameOfModal: 'Change Your Email',
                                            labelText: 'Your email',
                                            prefixIcon: const Icon(
                                              Icons.email_outlined,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    );
                                  },
                                  icon: const Icon(
                                    IconlyLight.arrow_right,
                                    color: Color(0xff1D592C),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
