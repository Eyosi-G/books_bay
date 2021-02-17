import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountRepository accountRepository;
  RegisterBloc(this.accountRepository) : super(InitRegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is Register) {
      try {
        yield RegisterLoadingState();
        await accountRepository.createAccount(user: event.user);
        yield RegisterSuccessfulState();
      } catch (e) {
        yield RegisterFailedState("creating account failed");
      }
    }
  }
}
