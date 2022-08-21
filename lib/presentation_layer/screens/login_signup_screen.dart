import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_cubit.dart';
import 'package:la_vie/data_layer/bloc/login_cubit/login_states.dart';
import 'package:la_vie/presentation_layer/widgets/widget_login.dart';
import 'package:la_vie/presentation_layer/widgets/widget_sign_up.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: AlignmentDirectional.topEnd,
                    height: 100.0,
                    child: Image.asset('assets/images/image_tree.png'),
                  ),
                  SizedBox(
                    height: 32.0,
                    child: Image.asset('assets/images/la_vie.png'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Container(
                      height: 430.0,
                      child: Scaffold(
                        appBar: TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelColor: Theme.of(context).primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: const
                          [
                            Tab(text: 'Sign up',),
                            Tab(text: 'Login',),
                          ],
                        ),

                        body:Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: TabBarView(
                            children:
                            [
                              SingleChildScrollView(child: signUpWidget()),
                              SingleChildScrollView(child: loginWidget(context)),
                            ],
                          ),
                        ),

                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.bottomStart,
                    height: 90.0,
                    child: Image.asset('assets/images/image_tree2.png'),
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
