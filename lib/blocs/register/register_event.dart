import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class Register extends RegisterEvent {
  final User user;
  Register(this.user);

  @override
  List<Object> get props => [user];
}
