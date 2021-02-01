import 'package:flutter/foundation.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({@required this.message});
}

class LoginSucceedState extends LoginState {}
