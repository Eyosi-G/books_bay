import 'dart:convert';

import 'package:books_bay/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../constants.dart';

class AccountDataProvider {
  Future deleteAccount(
      {@required String token, @required String userId}) async {
    final client = Client();
    final response = await client.delete(
      Endpoints.deleteAccount(userId),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
  }

  Future createAccount({@required User user}) async {
    final client = Client();
    final response = await client.post(
      Endpoints.registerURL,
      headers: {
        'content-type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
  }

  Future updateAccount({@required String token, @required User user}) async {
    final client = Client();
    final response = await client.put(
      Endpoints.updateAccount,
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: json.encode(user.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
  }

  Future<User> getAccount(
      {@required String userId, @required String token}) async {
    final client = Client();
    final response = await client.get(
      Endpoints.getAccount(userId),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
    return User.fromJson(json.decode(response.body));
  }
}
