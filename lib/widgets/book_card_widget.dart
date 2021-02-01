import 'package:books_bay/models/book.dart';
import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  final double height;
  final double width;
  final String id;
  final String title;
  final String coverImage;
  final String author;
  BookCardWidget({
    this.height,
    this.width,
    this.id,
    this.coverImage,
    this.author,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Image.network(
                'https://ebooks-bay.herokuapp.com/api/v1/images/$coverImage',
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$title',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$author',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
