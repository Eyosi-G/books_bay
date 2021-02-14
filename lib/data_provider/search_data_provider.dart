import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../constants.dart';

class SearchDataProvider {
  Future<List<Book>> search(
      {@required String filter, @required String text}) async {
    final url =
        '${Endpoints.booksURL}?genre=${filter != null ? filter : ''}&search=${text != null ? text : ''}';
    final client = Client();
    final response = await client.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    final List<dynamic> _books = json.decode(response.body) as List;
    final books = _books.map((_book) => Book.fromJson(_book)).toList();
    return books;
  }
}
