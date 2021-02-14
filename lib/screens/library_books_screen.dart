import 'package:books_bay/blocs/library/library.dart';
import 'package:books_bay/widgets/failed_reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import './screens.dart';
import '../widgets/library_tile.dart';

class LibraryBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'my books',
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  BookFormScreen.routeName,
                  arguments: BookArg(
                    edit: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (ctx, state) {
          if (state is LibraryLoadingFailedState) {
            return FailedReloadWidget(() {});
          }
          if (state is LibraryLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LibraryLoadedState) {
            final books = state.books;
            if (books.isEmpty) {
              return Center(
                child: Text('Nothing on library'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (ctx, index) {
                  return LibraryTile(books[index]);
                },
                itemCount: state.books.length,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
