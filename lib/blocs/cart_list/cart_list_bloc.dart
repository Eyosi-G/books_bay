import 'dart:convert';

import 'package:books_bay/blocs/cart/cart_bloc.dart';
import 'package:books_bay/blocs/cart/cart_state.dart';
import 'package:books_bay/repository/cart_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_list_event.dart';
import 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartBloc cartBloc;
  final CartDataProvider dataProvider;

  CartListBloc({@required this.cartBloc, @required this.dataProvider})
      : super(CartListInitState()) {
    cartBloc.listen((e) {
      if (e is CartStateChanged && e.cartCount == 0) {
        add(FetchedBooks());
      }
    });
  }

  @override
  Stream<CartListState> mapEventToState(CartListEvent event) async* {
    if (event is FetchedBooks) {
      final books = await dataProvider.fetchBooks();
      yield CartListFinished(books);
    }
  }
}
