import 'dart:convert';

import 'package:books_bay/models/user.dart';
import 'package:http/http.dart';

import '../constants.dart';

class LoginDataProvider {
  Future login(User user) async {
    final user = User(email: "kebede@gmail.com", password: "kebede_password");
    final client = Client();
    final response = await client.post(
      Endpoints.loginURL,
      headers: {
        'content-type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    return null;
  }
}
