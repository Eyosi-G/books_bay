import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/blocs/library/library.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:books_bay/widgets/failed_reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './screens.dart';
import '../widgets/library_tile.dart';

class LibraryBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitThreeBounce(
      color: Colors.black,
      size: 20.0,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<PermissionBloc, PermissionState>(
              cubit: PermissionBloc(context.read<AccountRepository>())
                ..add(CheckPermission()),
              builder: (ctx, state) {
                if (state is PermissionLoadedState &&
                    state.permission.postPermission == "READ_WRITE") {
                  return IconButton(
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
                  );
                }
                return IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    size: 25,
                    color: Colors.black12,
                  ),
                  onPressed: () {},
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (ctx, state) {
          if (state is LibraryLoadingFailedState) {
            return FailedReloadWidget(() {
              context.read<LibraryBloc>().add(FetchBooksEvent());
            });
          }
          if (state is LibraryLoadingState) {
            return Center(child: spinKit);
          }
          if (state is LibraryLoadedState) {
            final books = state.books;
            if (books.isEmpty) {
              return Center(
                child: Text('You haven\'t posted yet.'),
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
