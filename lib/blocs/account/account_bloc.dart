import 'package:books_bay/repositories/account_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs.dart';

import 'account.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  final AuthBloc authbloc;
  AccountBloc({@required this.accountRepository, @required this.authbloc})
      : super(AccountInitState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchAccountEvent) {
      try {
        yield LoadingAccountState();
        final user = await accountRepository.getAccount();
        yield AccountFetchedState(user);
      } catch (e) {
        yield AccountFailedState("Fetching Account Information Failed");
      }
    }
    if (event is EditAccountEvent) {
      try {
        await accountRepository.updateAccount(event.user);
        final user = await accountRepository.getAccount();
        yield AccountFetchedState(user);
      } catch (e) {
        yield AccountFailedState("Editing Account Failed");
      }
    }
    if (event is DeleteAccountEvent) {
      try {
        await accountRepository.deleteAccount();
        authbloc.add(LogoutEvent());
      } catch (e) {
        yield AccountFailedState("Deleting Account Failed");
      }
    }
  }
}
