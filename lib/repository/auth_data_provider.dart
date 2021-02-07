import 'dart:convert';

import 'package:books_bay/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthDataProvider {
  static Future<Auth> getAuth() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final authMap = json.decode(instance.getString(kSharedPreferenceName));
      final auth = Auth.fromMap(authMap);
      final now = DateTime.now();
      if (auth.exp.isBefore(now)) {
        instance.remove(kSharedPreferenceName);
        return null;
      }
      return auth;
    } catch (e) {
      return null;
    }
  }

  static saveAuth(Map<String, dynamic> data) async {
    final instance = await SharedPreferences.getInstance();
    final response = await instance.setString(
        kSharedPreferenceName, json.encode(Auth.fromJson(data).toMap()));
  }
}
