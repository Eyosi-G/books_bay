import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './permission.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  AccountRepository accountRepository;
  PermissionBloc(this.accountRepository) : super(InitialPermissionState());

  @override
  Stream<PermissionState> mapEventToState(PermissionEvent event) async* {
    if (event is CheckPermission) {
      final user = await accountRepository.getAccount();
      yield PermissionLoadedState(user.permission);
    }
  }
}
