import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}
