import 'package:books_bay/blocs/cart/cart_bloc.dart';
import 'package:books_bay/blocs/cart/cart_event.dart';
import 'package:books_bay/blocs/cart_list/cart_list_bloc.dart';
import 'package:books_bay/blocs/cart_list/cart_list_event.dart';
import 'package:books_bay/blocs/cart_list/cart_list_state.dart';
import 'package:books_bay/repository/cart_data_provider.dart';
import 'package:books_bay/screens/splash_screen.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:books_bay/widgets/checkout_widget.dart';
import 'package:books_bay/widgets/custom_app_bar.dart';
import 'package:books_bay/widgets/dismissible_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc _cartBloc;
  CartListBloc _cartListBloc;
  @override
  void didChangeDependencies() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartListBloc = CartListBloc(_cartBloc, CartDataProvider());
    _cartListBloc.add(FetchedBooks());

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _cartListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final books = _cartBloc.books;
    final spinKit = SpinKitThreeBounce(
      color: Colors.black,
      size: 20.0,
    );
    return Scaffold(
      appBar: customAppBar(context, 'Shopping Bag'),
      body: BlocBuilder<CartListBloc, CartListState>(
        cubit: _cartListBloc,
        builder: (ctx, state) {
          if (state is CartListFinished) {
            final books = state.books;
            if (books.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/product_not_found.png'),
                    Text('Empty Bag')
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Dismissible(
                          child: BookTileWidget(books[index]),
                          key: ValueKey(index),
                          background: DismissibleBackgroundWidget(),
                          confirmDismiss: (direction) {
                            _cartBloc.add(BookRemovedFromCart(books[index]));
                            return Future.value(true);
                          },
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(height: 10);
                      },
                      itemCount: books.length,
                    ),
                  ),
                ),
                FlatButton(
                  minWidth: double.infinity,
                  color: Theme.of(context).buttonColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return CheckoutWidget(_cartListBloc);
                      },
                    );
                  },
                  child: Text(
                    'CHECKOUT',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              ],
            );
          }

          return Container(
            child: Center(
              child: spinKit,
            ),
          );
        },
      ),
    );
  }
}
