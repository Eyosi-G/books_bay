import 'package:books_bay/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

abstract class BooksListState extends Equatable {}

class InitialBooksListState extends BooksListState {
  @override
  List<Object> get props => [];
}

class BooksListLoadingState extends BooksListState {
  @override
  List<Object> get props => [];
}

class BooksListFetchedState extends BooksListState {
  final List<Book> books;
  final List<Book> bestSellers;
  BooksListFetchedState({@required this.books, @required this.bestSellers});

  @override
  List<Object> get props => [books, bestSellers];
}

class BooksListFetchFailedState extends BooksListState {
  final String message;
  BooksListFetchFailedState(this.message);
  @override
  List<Object> get props => [message];
}
