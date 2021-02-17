import 'package:flutter/material.dart';
import '../models/models.dart';
import '../app.dart';
import './screens.dart';

class ScreensRoute {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) => MainApp(),
      );
    }
    if (settings.name == BookDetailScreen.routeName) {
      final Book book = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => BookDetailScreen(book),
      );
    }
    if (settings.name == BookFormScreen.routeName) {
      final BookArg bookArg = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => BookFormScreen(bookArg: bookArg),
      );
    }
    if (settings.name == SettingScreen.routeName) {
      return MaterialPageRoute(
        builder: (_) => SettingScreen(),
      );
    }
    if (settings.name == SignUpScreen.routeName) {
      return MaterialPageRoute(
        builder: (_) => SignUpScreen(),
      );
    }
  }
}

class BookArg {
  final Book book;
  final bool edit;
  BookArg({this.book, this.edit});
}
