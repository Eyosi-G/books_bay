import 'package:books_bay/widgets/bag_wrapper.dart';
import 'package:books_bay/widgets/download_library_book_widget.dart';
import 'package:books_bay/widgets/library_book_widget.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';

class LibraryBooksScreen extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
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
