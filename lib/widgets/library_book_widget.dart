import 'package:books_bay/models/db_models/db_models.dart';
import 'package:books_bay/screens/book_reader_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LibraryBookWidget extends StatelessWidget {
  final Download download;
  LibraryBookWidget(this.download);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => BookReaderScreen(download)));
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(
            '${download.title}',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          backgroundColor: Colors.black38,
          subtitle: Text(
            '${download.author}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  color: Colors.white,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: Image.network(
          '${Endpoints.imageURL(download.coverImageName)}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
