import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {}

class InitRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessfulState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailedState extends RegisterState {
  final String message;
  RegisterFailedState(this.message);

  @override
  List<Object> get props => [message];
}
