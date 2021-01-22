import 'package:books_bay/widgets/download_library_book_widget.dart';
import 'package:books_bay/widgets/library_book_widget.dart';
import 'package:flutter/material.dart';

class LibraryBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: [
            Icon(Icons.shopping_bag),
          ],
        ),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          children: [
            LibraryBookWidget(),
            LibraryBookWidget(),
            LibraryBookWidget(),
            DownloadLibraryBookWidget(),
          ],
        ),
      ),
    );
  }
}
