import 'dart:collection';
import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:books_bay/repository/books_data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'books_list_event.dart';
import 'books_list_state.dart';

class BooksListBloc extends Bloc<BooksListEvent, BooksListState> {
  List<Book> _books = List<Book>();
  UnmodifiableListView<Book> get books => UnmodifiableListView(_books);
  final BooksDataProvider _booksDataProvider;
  BooksListBloc(this._booksDataProvider) : super(InitialBooksListState());

  @override
  Stream<BooksListState> mapEventToState(BooksListEvent event) async* {
    if (event is FetchedBooks) {
      try {
        yield BooksListLoadingState();
        await _fetchBooks();
        yield BooksListFetchedState();
      } catch (e) {
        yield BooksListFetchFailedState();
      }
    }
  }

  Future _fetchBooks() async {
    final books = await _booksDataProvider.fetchBooks();
    if (books != null) {
      _books = books;
    }
  }
}
