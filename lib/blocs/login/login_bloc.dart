import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_bay/models/user.dart';
import 'package:books_bay/repository/login_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginDataProvider _loginDataProvider;
  LoginBloc(this._loginDataProvider) : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptedLogin) {
      try {
        yield LoginLoadingState();
        await _loginAndSave(
          loginDataProvider: _loginDataProvider,
          user: User(
            email: event.email,
            password: event.password,
          ),
        );
        yield LoginSucceedState();
      } catch (e) {
        print(e);
        yield LoginFailedState(message: 'failed on network');
      }
    }
    if (event is FailedLoginEvent) {
      yield LoginFailedState(message: event.message);
    }
  }
}

Future _loginAndSave({LoginDataProvider loginDataProvider, User user}) async {
  final data = await loginDataProvider.login(user);
  if (data == null) {
    print(data);
    throw Error();
  }
  final instance = await SharedPreferences.getInstance();
  final response =
      await instance.setString(kSharedPreferenceName, json.encode(data));
  if (!response) {
    print(response);
    throw Error();
  }
}
