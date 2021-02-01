import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/login/login_bloc.dart';
import 'repository/login_data_provider.dart';
import 'screens/book_detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/scratch_screen.dart';
import 'screens/splash_screen.dart';
import 'widgets/bottom_navigation_bar_widget.dart';
import './blocs/auth/auth_state.dart';

//class MainApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      child: BlocBuilder<AuthBloc, AuthState>(
//        builder: (ctx, state) {
//          if (state is AuthenticatedState) {
//            return App(BottomNavigationBarWidget());
//          } else if (state is UnAuthenticatedState) {
//            return App(LoginScreen());
//          } else {
//            return SplashScreen();
//          }
//        },
//      ),
//    );
//  }
//}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    bloc.add(CheckAuthStatus());
    return MaterialApp(
      title: 'De Demo',
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
      home: BlocBuilder<AuthBloc, AuthState>(
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
