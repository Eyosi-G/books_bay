import 'dart:convert';

import 'package:books_bay/blocs/cart_list/cart_list_bloc.dart';
import 'package:books_bay/blocs/cart_list/cart_list_state.dart';
import 'package:books_bay/models/auth.dart';
import 'package:books_bay/models/checkout.dart';
import 'package:books_bay/repository/auth_data_provider.dart';
import 'package:books_bay/repository/checkout_data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import './checkout_state.dart';
import './checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartListBloc _cartListBloc;
  CheckoutDataProvider _checkoutDataProvider;
  CheckoutBloc(this._cartListBloc) : super(InitialCheckoutState()) {
    _checkoutDataProvider = CheckoutDataProvider();
    add(CheckoutLoaded());
  }

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    try {
      if (event is CheckoutLoaded) {
        final checkout = _getCheckouts();
        yield CheckoutCompletedState(checkout);
      }
      if (event is PayNow) {
        //todo: _generateCheckoutLink()
        final checkout = event.checkout;
        yield GeneratingLinkState();
        final generatedLink = await _generateCheckoutLink(checkout.books);
        if (generatedLink != null) yield CheckoutLinkGenerated(generatedLink);
      }
    } catch (e) {
      CheckoutErrorState('Error occurred');
    }
  }

  Checkout _getCheckouts() {
    if (_cartListBloc.state is CartListFinished) {
      final books = (_cartListBloc.state as CartListFinished).books;
      double price = 0;
      final booksId = books.map((book) {
        price += book.price;
        return book.id;
      }).toList();
      final checkout = Checkout(
        amount: books.length,
        books: booksId,
        totalPrice: price,
      );
      return checkout;
    }
    return null;
  }

  Future<String> _generateCheckoutLink(List<String> books) async {
    final auth = await AuthDataProvider.getAuth();
    final String link =
        await _checkoutDataProvider.generateLink(books, auth.token);
    return link;
  }
}
