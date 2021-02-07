import 'package:books_bay/blocs/library/library_bloc.dart';
import 'package:books_bay/blocs/library/library_event.dart';
import 'package:books_bay/blocs/library/library_state.dart';
import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/repository/library_data_provider.dart';
import 'package:books_bay/widgets/bag_wrapper.dart';
import 'package:books_bay/widgets/download_library_book_widget.dart';
import 'package:books_bay/widgets/library_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen.dart';

class LibraryBooksScreen extends StatefulWidget {
  @override
  _LibraryBooksScreenState createState() => _LibraryBooksScreenState();
}

class _LibraryBooksScreenState extends State<LibraryBooksScreen> {
  LibraryBloc _libraryBloc;
  @override
  void didChangeDependencies() {
    _libraryBloc = BlocProvider.of<LibraryBloc>(context);
    _libraryBloc.add(FetchLibraryBooksEvent());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          BagWrapper(),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        cubit: _libraryBloc,
        builder: (ctx, state) {
          if (state is InitialLibraryState) {
            return Center(
              child: Text('loading'),
            );
          }
          if (state is LibraryLoadedState) {
            final downloads = state.downloads;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) {
                  final download = downloads[index];
                  return DownloadLibraryBookWidget(download);
                },
                itemCount: downloads.length,
              ),
            );
          }
          return Center(
            child: Text('loading'),
          );
        },
      ),
    );
  }
}
