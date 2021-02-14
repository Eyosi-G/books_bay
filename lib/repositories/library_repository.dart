import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/data_provider/library_data_provider.dart';
import 'package:books_bay/models/book.dart';
import 'package:flutter/foundation.dart';

class LibraryRepository {
  final LibraryDataProvider libraryDataProvider;
  final AuthDataProvider authDataProvider;
  LibraryRepository(
      {@required this.authDataProvider, @required this.libraryDataProvider});

  Future createBook(Book book) async {
    final auth = await authDataProvider.getAuth();
    await libraryDataProvider.createBook(
      token: auth.token,
      book: book,
    );
  }

  Future<List<Book>> fetchMyBooks() async {
    final auth = await authDataProvider.getAuth();
    return await libraryDataProvider.fetchMyBooks(
        userId: auth.id, token: auth.token);
  }

  Future deleteBook(String bookId) async {
    final auth = await authDataProvider.getAuth();
    return await libraryDataProvider.deleteBook(
        bookId: bookId, token: auth.token);
  }

  Future editBook(Book book, bool isFileSelected) async {
    final auth = await authDataProvider.getAuth();
    return await libraryDataProvider.updateBook(
        token: auth.token, book: book, isFileSelected: isFileSelected);
  }
}
