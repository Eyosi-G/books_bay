import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {}

class AccountInitState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountFetchedState extends AccountState {
  final User user;
  AccountFetchedState(this.user);

  @override
  List<Object> get props => [user];
}

class AccountFailedState extends AccountState {
  final String message;
  AccountFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingAccountState extends AccountState {
  @override
  List<Object> get props => [];
}
