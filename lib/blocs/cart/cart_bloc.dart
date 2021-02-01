import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/models/book.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
//  List<Book> _books = [];
//  UnmodifiableListView<Book> get books => UnmodifiableListView(_books);

  CartBloc() : super(InitialCartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is BookAddedToCart) {
      yield* _addToCart(event.book);
    } else if (event is BookRemovedFromCart) {
      yield* _removeFromCart(event.book);
    }
  }

  Stream<CartState> _addToCart(Book book) async* {
    final box = await Hive.openBox('carts');
    final List<Book> books = [];
    box.values.forEach((value) {
      final Map<String, dynamic> mapBook = json.decode(value);
      final book = Book.fromJson(mapBook);
      books.add(book);
    });
    final dbBook = books.firstWhere(
      (_book) => _book.id == book.id,
      orElse: () => null,
    );
    if (dbBook == null) {
      box.add(json.encode(book.toJson()));
      yield CartStateChanged(books.length + 1);
    }
  }

  Stream<CartState> _removeFromCart(Book book) async* {
    final box = await Hive.openBox('carts');
    box.toMap().forEach((key, value) async {
      final Map<String, dynamic> mapBook = json.decode(value);
      final _book = Book.fromJson(mapBook);
      if (_book.id == book.id) {
        await box.delete(key);
      }
    });

    yield CartStateChanged(box.values.length);
  }
}
