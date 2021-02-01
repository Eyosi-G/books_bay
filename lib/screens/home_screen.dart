import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/blocs/auth/auth_event.dart';
import 'package:books_bay/blocs/books_list/books_list_bloc.dart';
import 'package:books_bay/blocs/books_list/books_list_event.dart';
import 'package:books_bay/blocs/books_list/books_list_state.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/repository/books_data_provider.dart';
import 'package:books_bay/widgets/bag_wrapper.dart';
import 'package:books_bay/widgets/book_card_widget.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:books_bay/widgets/category_lists_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'book_detail_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import '../blocs/auth/auth_event.dart';

enum Selected { orders, logout }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BooksListBloc _booksListBloc;
  AuthBloc _authBloc;
  @override
  void didChangeDependencies() {
    _booksListBloc = BlocProvider.of<BooksListBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    if (_booksListBloc.books.isEmpty) {
      _booksListBloc.add(FetchedBooks());
    }
    super.didChangeDependencies();
  }

  _navigateToDetail(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return BookDetailScreen(book);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final spinKit = SpinKitThreeBounce(
      color: Colors.black,
      size: 20.0,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          BagWrapper(),
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Orders',
                  ),
                  value: Selected.orders,
                ),
                PopupMenuItem(
                  child: Text(
                    'Logout',
                  ),
                  value: Selected.logout,
                )
              ];
            },
            onSelected: (Selected selected) {
              if (selected == Selected.orders) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return OrdersScreen();
                    },
                  ),
                );
              } else if (selected == Selected.logout) {
                _authBloc.add(LogoutEvent());
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<BooksListBloc, BooksListState>(
        builder: (ctx, state) {
          print(state);
          if (state is InitialBooksListState) {
            return Center(
              child: spinKit,
            );
          }
          if (state is BooksListLoadingState) {
            return Center(
              child: spinKit,
            );
          }
          if (state is BooksListFetchFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/floading_failed.png',
                    width: 70,
                    height: 70,
                  ),
                ),
                Center(
                  child: Text('Loading Failed'),
                ),
                SizedBox(height: 10),
                OutlineButton(
                  onPressed: () {
                    _booksListBloc.add(FetchedBooks());
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          }
          if (state is BooksListFetchedState) {
            final books = _booksListBloc.books;
            final bestSellers =
                books?.where((book) => book.isBestSeller)?.toList();
            if (books.isEmpty) {
              return Text('no books');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Sellers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: bestSellers.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () =>
                                  _navigateToDetail(bestSellers[index]),
                              child: BookCardWidget(
                                height: height * 0.28,
                                width: width * 0.4,
                                title: bestSellers[index].title,
                                id: bestSellers[index].id,
                                author: bestSellers[index].author,
                                coverImage: bestSellers[index].coverImage,
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () => _navigateToDetail(books[index]),
                              child: BookTileWidget(books[index]),
                            );
                          },
                          itemCount: books.length,
                          separatorBuilder: (ctx, index) {
                            return Divider(
                              height: 7,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            ;
          }
          return Container();
        },
      ),
    );
  }
}
