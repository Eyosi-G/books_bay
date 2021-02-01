import 'package:books_bay/blocs/cart/cart_bloc.dart';
import 'package:books_bay/blocs/cart/cart_state.dart';
import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './badge.dart';

class BagWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: BlocBuilder<CartBloc, CartState>(
        builder: (ctx, state) {
          if (state is CartStateChanged) {
            print(state.cartCount);
            if (state.cartCount != 0)
              return Badge(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_bag),
                ),
                value: '${state.cartCount}',
              );
            else
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_bag),
              );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_bag),
          );
        },
      ),
      onPressed: () async {
//        final dbProvider = DatabaseProvider();
//        await dbProvider.retrieveAllBooks();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return CartScreen();
            },
          ),
        );
      },
    );
  }
}
