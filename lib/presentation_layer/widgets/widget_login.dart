import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_cubit.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_states.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';

TextEditingController? emailController = TextEditingController();
TextEditingController? passwordController = TextEditingController();

Widget loginWidget(context) {
  var formKey = GlobalKey<FormState>();

  return BlocConsumer<LoginCubit, LoginStates>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = LoginCubit.get(context);
      return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 45.0,
              width: 300.0,
              child: defaultTextFormField(
                context: context,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email Address must not be empty';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 45.0,
              width: 300.0,
              child: defaultTextFormField(
                context: context,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password must not be empty ';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            cubit.isLoginLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Container(
                    height: 45.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: ()
                      {
                        if (formKey.currentState!.validate())
                        {
                          cubit.userLogin(
                            email: emailController!.text,
                            password: passwordController!.text,
                            context: context,
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                      ),
                    ),
                  ),
              const SizedBox(
              height: 20.0,
                   ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xff979797),
                    ),
                  ),
                  Text(
                    ' or continue with ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 14),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xff979797),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()
                    {
                      cubit.signIn().then((value) =>
                      {
                        print(value),
                        cubit.userSignInWithGoogle(
                            firstName: value!.displayName,
                            lastName: value.displayName,
                            email: value.email,
                            id: value.id,
                            picture: "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png",
                            context: context,
                        ),
                      });
                    },
                    child:
                    Image.asset('assets/images/google.png'),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: () async
                    {
                      // await FacebookSignInModel
                      //     .signinWithFaceBook()
                      //     .then((value) {
                      //   flutterToast(
                      //       msg: FacebookSignInModel
                      //           .userDatafacebook?['name'],
                      //       backgroundColor:
                      //       AppColors.toastSuccess,
                      //       textColor: AppColors.white);
                      // });
                    },
                    child:
                    Image.asset('assets/images/facebook.png'),
                  )
                ],
              ),

          ],
        ),
      );
    },
  );
}
