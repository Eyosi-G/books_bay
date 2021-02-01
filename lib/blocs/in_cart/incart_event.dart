import 'package:books_bay/models/book.dart';

abstract class InCartEvent {}

class CheckInCartEvent extends InCartEvent {
  final Book book;
  CheckInCartEvent(this.book);
}
