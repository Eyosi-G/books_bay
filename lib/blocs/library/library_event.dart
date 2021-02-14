import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LibraryEvent extends Equatable {}

class AddBookEvent extends LibraryEvent {
  final Book book;
  AddBookEvent(this.book);
  @override
  List<Object> get props => [book];
}

class DeleteBookEvent extends LibraryEvent {
  final String bookId;
  DeleteBookEvent(this.bookId);
  @override
  List<Object> get props => [bookId];
}

class UpdateBookEvent extends LibraryEvent {
  final Book book;
  final bool isFileSelected;

  UpdateBookEvent({@required this.book, @required this.isFileSelected});

  @override
  List<Object> get props => [book, isFileSelected];
}

class FetchBooksEvent extends LibraryEvent {
  @override
  List<Object> get props => [];
}
