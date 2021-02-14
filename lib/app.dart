import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/books_list/books_list_bloc.dart';

import 'blocs/library/library.dart';
import 'repositories/repositories.dart';
import 'screens/book_form_screen.dart';
import 'screens/login_screen.dart';
import 'screens/screens.dart';
import 'widgets/bottom_navigation_bar_widget.dart';
import './blocs/auth/auth_state.dart';
import './blocs/books_list/books_list_event.dart';

class MainApp extends StatelessWidget {
  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (ctx, state) {
          if (state is AuthenticatedState) {
            return BottomNavigationBarWidget();
          } else if (state is UnAuthenticatedState) {
            return LoginScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

class StarterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(context.read<AuthRepository>())..add(CheckAuthStatus()),
        ),
        BlocProvider<BooksListBloc>(
          create: (_) => BooksListBloc(context.read<BooksRepository>())
            ..add(FetchedBooks()),
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibraryBloc>(
      create: (_) => LibraryBloc(
          booksListBloc: context.read<BooksListBloc>(),
          libraryRepository: context.read<LibraryRepository>())
        ..add(FetchBooksEvent()),
      child: MaterialApp(
        title: 'Book Bay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
          primaryColor: Color(0xff03989e),
          buttonColor: Color(0xff30475e),
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'OpenSans',
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        onGenerateRoute: BooksRoute.generateRoutes,
      ),
    );
  }
}
