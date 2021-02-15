import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {}

class FetchAccountEvent extends AccountEvent {
  @override
  List<Object> get props => [];
}

class DeleteAccountEvent extends AccountEvent {
  @override
  List<Object> get props => [];
}

class EditAccountEvent extends AccountEvent {
  final User user;
  EditAccountEvent(this.user);

  @override
  List<Object> get props => [user];
}
