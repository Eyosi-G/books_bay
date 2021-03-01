import 'dart:convert';

import 'package:books_bay/models/user.dart';
import 'package:http/http.dart';

import '../constants.dart';

class LoginDataProvider {
  Future login(User user) async {
    final client = Client();
    final response = await client
        .post(
          Endpoints.loginURL,
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode(user.toJson()),
        )
        .timeout(Duration(seconds: 10));
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
    final data = json.decode(response.body);
    return data;
  }
}
