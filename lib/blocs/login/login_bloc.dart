import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  AuthRepository authRepository;
  AuthBloc authBloc;
  LoginBloc({
    @required this.loginRepository,
    @required this.authRepository,
    @required this.authBloc,
  }) : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is AttemptedLogin) {
        yield LoginLoadingState();
        await _loginAndSave(
          user: User(
            email: event.email,
            password: event.password,
          ),
        );
      }
    } catch (e) {
      print(e);
      await Future.delayed(Duration(seconds: 2));
      yield LoginFailedState(message: "Failed to Login");
    }
  }

  Future _loginAndSave({User user}) async {
    final data = await loginRepository.login(user);
    await authRepository.saveAuth(data);
    authBloc.add(CheckAuthStatus());
  }
}
