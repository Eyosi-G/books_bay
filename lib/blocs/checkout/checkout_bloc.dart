import 'package:bloc/bloc.dart';
import 'package:books_bay/blocs/cart_list/cart_list_bloc.dart';
import 'package:books_bay/blocs/cart_list/cart_list_state.dart';
import 'package:books_bay/models/checkout.dart';

import './checkout_state.dart';
import './checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartListBloc _cartListBloc;
  CheckoutBloc(this._cartListBloc) : super(InitialCheckoutState()) {
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

  String _generateCheckoutLink(Checkout checkout) {
    return '';
  }
}
