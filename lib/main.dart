import 'dart:io';

import 'package:books_bay/data_provider/comment_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'data_provider/auth_data_provider.dart';
import 'data_provider/books_data_provider.dart';
import 'data_provider/library_data_provider.dart';
import 'data_provider/login_data_provider.dart';
import 'repositories/auth_repository.dart';
import 'repositories/books_respository.dart';
import 'repositories/comment_repository.dart';
import 'repositories/library_repository.dart';
import 'repositories/login_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        )
      ],
      child: StarterApp(),
    ),
  );
}
