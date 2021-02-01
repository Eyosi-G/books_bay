import 'package:books_bay/models/book.dart';

abstract class CartListState {}

class CartListInitState extends CartListState {}

class CartListLoading extends CartListState {}

class CartListFinished extends CartListState {
  final List<Book> books;
  CartListFinished(this.books);
}
