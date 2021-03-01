import 'package:books_bay/models/book.dart';

abstract class SearchState {}

class InitialSearchState extends SearchState {}

class SearchChanged extends SearchState {
  final List<Book> books;
  SearchChanged(this.books);
}

class SearchLoadingState extends SearchState {}
class SearchFailedState extends SearchState {
  final String message;
  SearchFailedState(this.message);
}