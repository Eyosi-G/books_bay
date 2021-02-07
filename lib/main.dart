import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/books_list/books_list_bloc.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/library/library_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'db_provider/database_provider.dart';
import 'repository/books_data_provider.dart';
import 'repository/login_data_provider.dart';
import 'screens/scratch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<BooksListBloc>(
          create: (_) => BooksListBloc(
            BooksDataProvider(),
          ),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        BlocProvider<LibraryBloc>(
          create: (_) => LibraryBloc(),
        ),
      ],
      child: App(),
    ),
  );
}
