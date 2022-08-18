import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/sign_up_cubit/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(InitialSignUpState());

  static SignUpCubit get(context)=> BlocProvider.of(context);

}