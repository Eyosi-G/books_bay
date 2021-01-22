import 'package:flutter/material.dart';

import 'screens/book_detail_screen.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'OpenSans',
        primaryColor: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'OpenSans',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      home: BottomNavigationBarWidget(),
    );
  }
}
