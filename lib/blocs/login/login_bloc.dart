import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/models/auth.dart';
import 'package:books_bay/models/user.dart';
import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/data_provider/login_data_provider.dart';
import 'package:books_bay/repositories/auth_repository.dart';
import 'package:books_bay/repositories/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  AuthRepository authRepository;
  LoginBloc({
    @required this.loginRepository,
    @required this.authRepository,
  }) : super(InitialLoginState());

  @override
  void onChange(Change<LoginState> change) {
    print(change);
  }

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
        yield LoginSucceedState();
      }
      if (event is FailedLoginEvent) {
        yield LoginFailedState(message: event.message);
      }
    } catch (e) {
      print(e);
      yield LoginFailedState(message: 'failed on network');
    }
  }

  Future _loginAndSave({User user}) async {
    final data = await loginRepository.login(user);
    await authRepository.saveAuth(data);
  }
}
