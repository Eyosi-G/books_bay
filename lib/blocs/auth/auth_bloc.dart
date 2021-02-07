import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_bay/models/auth.dart';
import 'package:books_bay/repository/auth_data_provider.dart';
import 'package:books_bay/repository/library_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckAuthStatus) {
      await Future.delayed(Duration(seconds: 5));
      yield* _checkCurrentUser();
    }
    if (event is LogoutEvent) {
      await _logout();
      yield UnAuthenticatedState();
    }
  }

  Stream<AuthState> _checkCurrentUser() async* {
    try {
      final auth = await AuthDataProvider.getAuth();
      if (auth == null) {
        yield UnAuthenticatedState();
      } else {
        await LibraryDataProvider().fetchAndSave();
        yield AuthenticatedState();
      }
    } catch (e) {
      yield UnAuthenticatedState();
    }
  }

  _logout() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove(kSharedPreferenceName);
  }
}
