abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  final String role;
  AuthenticatedState(this.role);
}

class UnAuthenticatedState extends AuthState {}
