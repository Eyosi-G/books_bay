import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {}

class AttemptedLogin extends LoginEvent {
  final String email;
  final String password;
  AttemptedLogin({@required this.password, @required this.email});

  @override
  List<Object> get props => [email, password];
}
