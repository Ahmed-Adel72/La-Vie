import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_cubit.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_states.dart';
import 'package:la_vie/presentation_layer/shared/components/components.dart';

TextEditingController? firstNameController = TextEditingController();
TextEditingController? lastNameController = TextEditingController();
TextEditingController? emailController = TextEditingController();
TextEditingController? passwordController = TextEditingController();
TextEditingController? confirmPasswordController = TextEditingController();

Widget signUpWidget() {
  var formKey = GlobalKey<FormState>();
  return BlocConsumer<LoginCubit, LoginStates>(
    listener: (context, state){},
    builder: (context, state)
    {
      var cubit=LoginCubit.get(context);
      return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      'First name',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 137.0,
                      child: defaultTextFormField(
                        context: context,
                        controller: firstNameController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First Name must not be empty ';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      'Last name',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 137.0,
                      child: defaultTextFormField(
                        context: context,
                        controller: lastNameController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last Name must not be empty ';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Email',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 40.0,
              width: 300.0,
              child: defaultTextFormField(
                context: context,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty ';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Password',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 40.0,
              width: 300.0,
              child: defaultTextFormField(
                context: context,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password must not be empty';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Confirm password',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 40.0,
              width: 300.0,
              child: defaultTextFormField(
                context: context,
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm password must not be empty';
                  }
                },
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            cubit.isSignUpLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
            ):Container(
              height: 40.0,
              width: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Theme.of(context).primaryColor,
              ),
              child: MaterialButton(
                onPressed: ()
                {
                  if(firstNameController!.text.isEmpty||lastNameController!.text.isEmpty||emailController!.text.isEmpty||passwordController!.text.isEmpty)
                  {
                    showToast(message: 'Please fill all requires', toastState: ToastState.error);
                  }
                  else if(passwordController!.text!=confirmPasswordController!.text)
                  {
                    showToast(message: 'Confirm password isn\'t same password' , toastState: ToastState.error);
                  }
                  else
                    {
                      cubit.userSignUp(
                        firstName: firstNameController!.text,
                        lastName: lastNameController!.text,
                        email: emailController!.text,
                        password: passwordController!.text,
                        context: context,
                      );
                    }
                },
                child: Text(
                  'Sign up',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white, fontSize: 16.0,),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}