import 'package:books_bay/data_provider/comment_data_provider.dart';
import 'package:books_bay/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'data_provider/data_providers.dart';
import 'repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => BooksRepository(BooksDataProvider()),
        ),
        RepositoryProvider(
          create: (_) => AuthRepository(AuthDataProvider()),
        ),
        RepositoryProvider(
          create: (_) => LoginRepository(LoginDataProvider()),
        ),
        RepositoryProvider(
          create: (_) => CommentRepository(
            authDataProvider: AuthDataProvider(),
            commentDataProvider: CommentDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (_) => LibraryRepository(
            libraryDataProvider: LibraryDataProvider(),
            authDataProvider: AuthDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (_) => AccountRepository(
            accountDataProvider: AccountDataProvider(),
            authDataProvider: AuthDataProvider(),
          ),
        ),
      ],
      child: StarterApp(),
    ),
  );
}
