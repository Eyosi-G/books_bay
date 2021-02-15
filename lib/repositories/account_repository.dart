import 'package:books_bay/data_provider/account_data_provider.dart';
import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/models/models.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  final AccountDataProvider accountDataProvider;
  final AuthDataProvider authDataProvider;
  AccountRepository(
      {@required this.accountDataProvider, @required this.authDataProvider});
  Future<User> getAccount() async {
    final auth = await authDataProvider.getAuth();
    return await accountDataProvider.getAccount(
      userId: auth.id,
      token: auth.token,
    );
  }

  Future updateAccount(User user) async {
    final auth = await authDataProvider.getAuth();
    await accountDataProvider.updateAccount(token: auth.token, user: user);
  }

  Future deleteAccount() async {
    final auth = await authDataProvider.getAuth();
    await accountDataProvider.deleteAccount(token: auth.token, userId: auth.id);
  }
}
