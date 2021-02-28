import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  final String role;
  AuthenticatedState(this.role);

  @override
  List<Object> get props => [role];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
