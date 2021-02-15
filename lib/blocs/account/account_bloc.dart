import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/blocs/auth/auth_event.dart';
import 'package:books_bay/repositories/account_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  final AuthBloc authbloc;
  AccountBloc({@required this.accountRepository, @required this.authbloc})
      : super(AccountInitState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    try {
      if (event is FetchAccountEvent) {
        yield LoadingAccountState();
        final user = await accountRepository.getAccount();
        yield AccountFetchedState(user);
      }
      if (event is EditAccountEvent) {
        await accountRepository.updateAccount(event.user);
        final user = await accountRepository.getAccount();
        yield AccountFetchedState(user);
      }
      if (event is DeleteAccountEvent) {
        await accountRepository.deleteAccount();
        authbloc.add(LogoutEvent());
      }
    } catch (e) {
      print(e);
      yield AccountFailedState("someting went wrong");
    }
  }
}
