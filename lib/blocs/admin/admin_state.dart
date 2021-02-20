import 'package:books_bay/models/models.dart';

abstract class AdminState {}

class InitialUsersListState extends AdminState {}

class LoadingUsersList extends AdminState {}

class UsersListLoaded extends AdminState {
  final List<User> users;
  UsersListLoaded(this.users);
}

class FailedState extends AdminState {
  final String message;

  FailedState(this.message);
}
