import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_bay/models/auth.dart';
import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/data_provider/library_data_provider.dart';
import 'package:books_bay/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckAuthStatus) {
      await Future.delayed(Duration(seconds: 2));
      yield* _checkCurrentUser();
    }
    if (event is LogoutEvent) {
      await _logout();
      yield UnAuthenticatedState();
    }
    if (event is CheckAuthExpires) {
      yield* _checkTokenState();
    }
  }

  Stream<AuthState> _checkTokenState() async* {
    final auth = await authRepository.getAuth();
    print(auth);
    if (auth == null) {
      await _logout();
      yield UnAuthenticatedState();
    }
  }

  Stream<AuthState> _checkCurrentUser() async* {
    try {
      final auth = await authRepository.getAuth();
      if (auth == null) {
        yield UnAuthenticatedState();
      } else {
        //await LibraryDataProvider().fetchAndSave();
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
