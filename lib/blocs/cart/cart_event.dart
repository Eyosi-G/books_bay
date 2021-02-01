import 'package:books_bay/models/book.dart';

abstract class CartEvent {}

class BookAddedToCart extends CartEvent {
  final Book book;
  BookAddedToCart(this.book);
}

class BookRemovedFromCart extends CartEvent {
  final Book book;
  BookRemovedFromCart(this.book);
}
