import 'package:books_bay/repositories/admin/admin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;
  AdminBloc(this.adminRepository) : super(InitialUsersListState());

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is FetchUsers) {
      try {
        yield LoadingUsersList();
        final users = await adminRepository.fetchUsers();
        yield UsersListLoaded(users);
      } catch (e) {
        yield FailedState("Couldn't load users");
      }
    }
    if (event is UpdateUserPermission) {
      await adminRepository.updateUserPermission(
          permission: event.permission, userId: event.userId);
      final users = await adminRepository.fetchUsers();
      yield UsersListLoaded(users);
    }
  }
}
