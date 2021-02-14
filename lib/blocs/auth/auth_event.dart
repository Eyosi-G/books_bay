abstract class AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class CheckAuthExpires extends AuthEvent {}
