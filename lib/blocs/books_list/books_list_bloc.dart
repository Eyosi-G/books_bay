import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/books_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'books_list.dart';

class BooksListBloc extends Bloc<BooksListEvent, BooksListState> {
  List<Book> _books = List<Book>();
  List<Book> _bestSellers = List<Book>();

  final BooksRepository booksRepository;
  BooksListBloc(this.booksRepository) : super(InitialBooksListState());

  @override
  Stream<BooksListState> mapEventToState(BooksListEvent event) async* {
    try {
      if (event is FetchedBooks) {
        yield BooksListLoadingState();
        await _fetchBooks();
        yield BooksListFetchedState(
          books: _books,
          bestSellers: _bestSellers,
        );
      }
    } catch (e) {
      yield BooksListFetchFailedState("Failed Loading Books");
    }
  }

  Future _fetchBooks() async {
    final books = await booksRepository.fetchBooks();
    if (books != null) {
      _books = books;
      _bestSellers = books.where((book) => book.isBestSeller).toList();
    }
  }
}
