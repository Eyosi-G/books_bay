import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/blocs/auth/auth_event.dart';
import 'package:books_bay/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/library_books_screen.dart';
import '../screens/home_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final _screens = [
    HomeScreen(),
    LibraryBooksScreen(),
    SearchScreen(),
  ];
  int _currentIndex = 0;
  _changeScreens(int index) {
    //BlocProvider.of<AuthBloc>(context).add(CheckAuthExpires());
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 38,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
          ],
          onTap: _changeScreens,
          currentIndex: _currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 16,
        ),
      ),
    );
  }
}
