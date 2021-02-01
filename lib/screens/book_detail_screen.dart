import 'dart:ui';

import 'package:books_bay/blocs/books_list/books_list_bloc.dart';
import 'package:books_bay/blocs/cart/cart_bloc.dart';
import 'package:books_bay/blocs/cart/cart_event.dart';
import 'package:books_bay/blocs/cart/cart_state.dart';
import 'package:books_bay/blocs/in_cart/incart_bloc.dart';
import 'package:books_bay/blocs/in_cart/incart_event.dart';
import 'package:books_bay/blocs/in_cart/incart_state.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/models/comment.dart';
import 'package:books_bay/widgets/bag_wrapper.dart';
import 'package:books_bay/widgets/category_chip.dart';
import 'package:books_bay/widgets/review_tile.dart';
import 'package:books_bay/widgets/write_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen(this.book);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  CartBloc _cartBloc;
  InCartBloc _inCartBloc = InCartBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _inCartBloc.add(CheckInCartEvent(widget.book));
    super.didChangeDependencies();
  }

  _addToBag() {
    _cartBloc.add(
      BookAddedToCart(widget.book),
    );
    _inCartBloc.add(
      CheckInCartEvent(widget.book),
    );
  }

  _openReview() {
    _scaffoldKey.currentState.showBottomSheet(
      (context) => WriteReviewScreen(),
      elevation: 10,
    );
  }

  _bottomTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.book.price.toStringAsFixed(2)} ETB',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            BlocBuilder<InCartBloc, InCartState>(
              cubit: _inCartBloc,
              builder: (ctx, state) {
                if (state is InCartStateChanged) {
                  if (state.isInCart) {
                    return FlatButton.icon(
                      color: Theme.of(context).primaryColor,
                      onPressed: null,
                      label: Text('Add To Bag'),
                      disabledColor: Colors.grey,
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textColor: Colors.white,
                    );
                  }
                }
                return FlatButton.icon(
                  color: Theme.of(context).primaryColor,
                  onPressed: _addToBag,
                  label: Text('Add To Bag'),
                  disabledColor: Colors.grey,
                  icon: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textColor: Colors.white,
                );
              },
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          BagWrapper(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Card(
                        elevation: 5,
                        child: Image.network(
                          Endpoints.imageUrl(widget.book.coverImage),
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        '${widget.book.title}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Center(
                      child: Text(
                        '${widget.book.author}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.book.description}',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                      textAlign: TextAlign.justify,
//                      softWrap: true,
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 3,
                      children: widget.book.genre
                          .map((_genre) => CategoryChip(category: _genre))
                          .toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 25,
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: _openReview,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: widget.book.comments
                          .map((comment) => ReviewTile())
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            _bottomTile(),
          ],
        ),
      ),
    );
  }
}
