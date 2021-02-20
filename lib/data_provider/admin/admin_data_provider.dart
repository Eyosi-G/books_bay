import 'dart:convert';

import 'package:books_bay/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../constants.dart';

class AdminDataProvider {
  Future<List<User>> fetchUsers({@required token}) async {
    final client = Client();
    final response = await client.get(
      Endpoints.getUsersURL,
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
    final jsonUsers = json.decode(response.body) as List;
    return jsonUsers.map((jsonUser) => User.fromJson(jsonUser)).toList();
  }

  Future updateUserPermission(
      {@required String token,
      @required Permission permission,
      @required String userId}) async {
    final client = Client();
    final response = await client.patch(Endpoints.updatePermissionURL,
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode({
          "userId": userId,
          "permissions": permission.toJson(),
        }));
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("response failed");
    }
  }
}
