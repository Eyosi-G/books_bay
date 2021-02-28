import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  AuthBloc authBloc;
  MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository);
  });

  tearDown(() {
    authBloc?.close();
  });

  test("initial state is correct", () {
    print(authBloc.state);
    expect(authBloc.state, InitialAuthState());
  });

  test("Check state for expired token", () {
    authBloc.add(CheckAuthStatus());
    when(authRepository.getAuth()).thenAnswer(
      (realInvocation) => Future.error(Exception("Token expired")),
    );
    expectLater(
      authBloc,
      emits(UnAuthenticatedState()),
    );
  });

  test("Check state for empty token", () {
    authBloc.add(CheckAuthStatus());
    when(authRepository.getAuth()).thenAnswer(
      (realInvocation) => Future.error(Exception()),
    );
    expectLater(
      authBloc,
      emits(UnAuthenticatedState()),
    );
  });

  test("successful authentication state", () {
    authBloc.add(CheckAuthStatus());
    when(authRepository.getAuth()).thenAnswer(
      (realInvocation) => Future.value(Auth(role: "user")),
    );
    expectLater(authBloc, emits(AuthenticatedState("user")));
  });

  test("check state when logout", () {
    authBloc.add(LogoutEvent());
    expectLater(authBloc, emits(UnAuthenticatedState()));
  });
}
