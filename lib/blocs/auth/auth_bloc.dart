import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckAuthStatus) {
//      await _checkCurrentUser();
      await Future.delayed(Duration(seconds: 5));
      yield AuthenticatedState();
    }
    if (event is LogoutEvent) {
      yield UnAuthenticatedState();
    }
  }
}

_checkCurrentUser() async {
  final instance = await SharedPreferences.getInstance();
  print(json.decode(instance.getString(kSharedPreferenceName)));
}
