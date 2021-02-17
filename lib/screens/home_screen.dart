import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/blocs/auth/auth_event.dart';
import 'package:books_bay/blocs/books_list/books_list_bloc.dart';
import 'package:books_bay/blocs/books_list/books_list_event.dart';
import 'package:books_bay/blocs/books_list/books_list_state.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/data_provider/books_data_provider.dart';
import 'package:books_bay/widgets/book_card_widget.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:books_bay/widgets/failed_reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'book_detail_screen.dart';
import '../blocs/auth/auth_event.dart';
import 'screens.dart';

enum Select { SETTING, LOGOUT }

class HomeScreen extends StatelessWidget {
  _navigateToDetail({
    @required Book book,
    @required BuildContext context,
  }) {
    Navigator.of(context).pushNamed(
      BookDetailScreen.routeName,
      arguments: book,
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
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Settings',
                  ),
                  value: Select.SETTING,
                ),
                PopupMenuItem(
                  child: Text(
                    'Logout',
                  ),
                  value: Select.LOGOUT,
                )
              ];
            },
            onSelected: (selected) {
              if (selected == Select.LOGOUT) {
                context.read<AuthBloc>().add(LogoutEvent());
              }

              if (selected == Select.SETTING) {
                Navigator.of(context).pushNamed(SettingScreen.routeName);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<BooksListBloc, BooksListState>(
        builder: (ctx, state) {
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
            return FailedReloadWidget(() {
              context.read<BooksListBloc>().add(FetchedBooks());
            });
          }
          if (state is BooksListFetchedState) {
            final books = state.books;
            final bestSellers = state.bestSellers;
            if (books.isEmpty) {
              return Center(child: Text('no books'));
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
                              onTap: () => _navigateToDetail(
                                book: bestSellers[index],
                                context: context,
                              ),
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
                              onTap: () => _navigateToDetail(
                                book: books[index],
                                context: context,
                              ),
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
