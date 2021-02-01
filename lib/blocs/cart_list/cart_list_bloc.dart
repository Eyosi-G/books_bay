import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_bay/blocs/cart/cart_bloc.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/repository/cart_data_provider.dart';

import 'cart_list_event.dart';
import 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartBloc cartBloc;
  final CartDataProvider _dataProvider;

  CartListBloc(this.cartBloc, this._dataProvider) : super(CartListInitState()) {
    cartBloc.listen((e) {
      add(FetchedBooks());
    });
  }

  @override
  Stream<CartListState> mapEventToState(CartListEvent event) async* {
    if (event is FetchedBooks) {
      final books = await _dataProvider.fetchBooks();
      yield CartListFinished(books);
    }
  }
}
