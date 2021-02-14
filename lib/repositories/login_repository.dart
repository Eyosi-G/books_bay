import 'package:books_bay/data_provider/login_data_provider.dart';
import 'package:books_bay/models/user.dart';

class LoginRepository {
  final LoginDataProvider dataProvider;
  LoginRepository(this.dataProvider);
  Future login(User user) async {
    return await dataProvider.login(user);
  }
}
