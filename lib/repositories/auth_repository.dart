import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/models/auth.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;
  AuthRepository(this.authDataProvider);
  Future<Auth> getAuth() async {
    return await authDataProvider.getAuth();
  }

  saveAuth(Map<String, dynamic> data) async {
    await authDataProvider.saveAuth(data);
  }
}
