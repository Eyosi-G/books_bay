import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:http/http.dart';
import '../constants.dart';

class BooksDataProvider {
  Future<List<Book>> fetchBooks() async {
    final client = Client();
    final response = await client.get(
      Endpoints.booksURL,
      headers: {
        'content-type': 'application/json',
      },
    ).timeout(Duration(seconds: 10));
    if (!(response.statusCode < 300 && response.statusCode >= 200)) {
      throw Exception("fetching books failed");
    }
    final List<dynamic> _books = json.decode(response.body) as List;
    final books = _books.map((_book) => Book.fromJson(_book)).toList();
    return books;
  }
}
