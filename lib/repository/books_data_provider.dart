import 'dart:convert';

import 'package:http/http.dart';
import '../constants.dart';

class BooksDataProvider {
  Future<List<dynamic>> fetchBooks() async {
    final client = Client();
    final response = await client.get(
      Endpoints.booksURL,
      headers: {
        'content-type': 'application/json',
      },
    );
    return json.decode(response.body).toList();
  }
}
