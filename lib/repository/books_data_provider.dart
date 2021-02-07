import 'dart:convert';

import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'package:http/http.dart';
import '../constants.dart';

class BooksDataProvider {
  Future<List<Book>> fetchBooks() async {
    try {
      final client = Client();
      final response = await client.get(
        Endpoints.booksURL,
        headers: {
          'content-type': 'application/json',
        },
      );
      final List<dynamic> _books = json.decode(response.body) as List;
      final books = _books.map((_book) => Book.fromJson(_book)).toList();
      return books;
    } catch (e) {
      return null;
    }
  }
}
