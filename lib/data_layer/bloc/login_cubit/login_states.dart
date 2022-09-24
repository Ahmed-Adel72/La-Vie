abstract class LoginStates {}

class InitialLoginStates extends LoginStates{}

class UserLoginLoadingState extends LoginStates{}

class UserLoginSuccessState extends LoginStates{}

class UserLoginErrorState extends LoginStates{}

class UserSignUpLoadingState extends LoginStates{}

class UserSignUpSuccessState extends LoginStates{}

class UserSignUpErrorState extends LoginStates{}
