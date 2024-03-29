import 'package:books_bay/models/book.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class BookTileWidget extends StatelessWidget {
  final Book book;
  BookTileWidget(this.book);
  @override
  Widget build(BuildContext context) {
    final double height = 90;
    final double width = 70;
    return Container(
      height: height,
      child: Row(
        children: [
          Container(
            height: height,
            width: width,
            color: Theme.of(context).primaryColor,
            child: Image.network(
              Endpoints.imageURL(book.coverImage),
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${book.title}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${book.author}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
