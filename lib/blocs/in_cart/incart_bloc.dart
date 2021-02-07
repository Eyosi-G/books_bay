import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import 'incart_event.dart';
import 'incart_state.dart';

class InCartBloc extends Bloc<InCartEvent, InCartState> {
  InCartBloc() : super(InitialInCartState());

  @override
  Stream<InCartState> mapEventToState(InCartEvent event) async* {
    if (event is CheckInCartEvent) {
      yield* _checkInCart(event.book.id);
    }
  }

  Stream<InCartState> _checkInCart(String bookId) async* {
    final box = await Hive.openBox(kHiveCartName);
    final books = box.values.toList();
    for (int i = 0; i < books.length; i++) {
      final Map<String, dynamic> mapBook = json.decode(books[i]);
      final book = Book.fromJson(mapBook);
      if (book.id == bookId) {
        yield InCartStateChanged(true);
        break;
      }
    }
  }
}
