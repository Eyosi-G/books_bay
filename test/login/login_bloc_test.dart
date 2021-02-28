import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

main() {
  MockLoginRepository loginRepository;
  MockAuthRepository authRepository;
  AuthBloc authBloc;
  LoginBloc loginBloc;

  setUp(() {
    loginRepository = MockLoginRepository();
    authRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository);
    loginBloc = LoginBloc(
        loginRepository: loginRepository,
        authRepository: authRepository,
        authBloc: authBloc);
  });

  tearDown(() {
    authBloc?.close();
    loginBloc?.close();
  });

  test("successful login state test", () {
    loginBloc.add(AttemptedLogin(password: "abebe", email: "abebe@gmail.com"));
    when(loginRepository.login(User()))
        .thenAnswer((realInvocation) => Future.value());
    when(authRepository.getAuth())
        .thenAnswer((realInvocation) => Future.value(Auth(role: "user")));
    expectLater(loginBloc, emits(LoginLoadingState()));
    expectLater(authBloc, emits(AuthenticatedState("user")));
  });
}
