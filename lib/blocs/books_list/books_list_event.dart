import 'package:equatable/equatable.dart';

abstract class BooksListEvent extends Equatable {}

class FetchedBooks extends BooksListEvent {
  @override
  List<Object> get props => [];
}
