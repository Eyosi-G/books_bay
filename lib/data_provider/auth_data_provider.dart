import 'dart:convert';

import 'package:books_bay/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthDataProvider {
  AuthDataProvider._();
  static final _instance = AuthDataProvider._();
  factory AuthDataProvider() => _instance;
  Future<Auth> getAuth() async {
    final instance = await SharedPreferences.getInstance();
    final authMap = json.decode(instance.getString(kSharedPreferenceName));
    final auth = Auth.fromMap(authMap);
    final now = DateTime.now();
    if (now.isAfter(auth.exp)) {
      instance.remove(kSharedPreferenceName);
      throw Exception('Token expired');
    }
    return auth;
  }

  saveAuth(Map<String, dynamic> data) async {
    final instance = await SharedPreferences.getInstance();
    final response = await instance.setString(
        kSharedPreferenceName, json.encode(Auth.fromJson(data).toMap()));
    if (!response) throw Exception('Storing auth information failed');
  }
}
