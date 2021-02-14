import 'package:books_bay/data_provider/books_data_provider.dart';
import 'package:books_bay/models/book.dart';

class BooksRepository {
  final BooksDataProvider booksDataProvider;
  BooksRepository(this.booksDataProvider);
  Future<List<Book>> fetchBooks() async {
    return await booksDataProvider.fetchBooks();
  }
}
