import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:hive/hive.dart';

class CartDataProvider {
  Future<List<Book>> fetchBooks() async {
    try{
      final box = await Hive.openBox('carts');
      final List<Book> books = [];
      box.values.forEach((value) {
        final Map<String, dynamic> mapBook = json.decode(value);
        final book = Book.fromJson(mapBook);
        books.add(book);
      });
      return books;
    }catch(e){
      return null;
    }

  }
}
