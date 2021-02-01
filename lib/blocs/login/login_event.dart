import 'package:flutter/foundation.dart';

abstract class LoginEvent {}

class AttemptedLogin extends LoginEvent {
  final String email;
  final String password;
  AttemptedLogin({@required this.password, @required this.email});
}

class FailedLoginEvent extends LoginEvent {
  final String message;
  FailedLoginEvent({@required this.message});
}
