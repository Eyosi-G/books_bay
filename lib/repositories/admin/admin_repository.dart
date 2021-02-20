import 'package:books_bay/data_provider/data_providers.dart';
import 'package:books_bay/models/models.dart';
import 'package:flutter/foundation.dart';

class AdminRepository {
  AuthDataProvider authDataProvider;
  AdminDataProvider adminDataProvider;
  AdminRepository({
    @required this.adminDataProvider,
    @required this.authDataProvider,
  });

  Future<List<User>> fetchUsers() async {
    final auth = await authDataProvider.getAuth();
    return await adminDataProvider.fetchUsers(token: auth.token);
  }

  Future updateUserPermission(
      {@required Permission permission, @required String userId}) async {
    final auth = await authDataProvider.getAuth();
    return await adminDataProvider.updateUserPermission(
      token: auth.token,
      permission: permission,
      userId: userId,
    );
  }
}
