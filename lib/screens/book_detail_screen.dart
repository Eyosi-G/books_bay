import 'dart:ui';

import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/blocs/comments_list/comments_list_bloc.dart';
import 'package:books_bay/blocs/comments_list/comments_list_event.dart';
import 'package:books_bay/blocs/comments_list/comments_list_state.dart';

import 'package:books_bay/models/book.dart';

import 'package:books_bay/repositories/comment_repository.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:books_bay/widgets/review_tile.dart';
import 'package:books_bay/widgets/widgets.dart';
import 'package:books_bay/widgets/write_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class BookDetailScreen extends StatefulWidget {
  static const routeName = "detail_screen";
  final Book book;

  BookDetailScreen(this.book);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  CommentsListBloc _commentsListBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _commentsListBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _commentsListBloc = CommentsListBloc(
      commentRepository: context.read<CommentRepository>(),
    );
    _commentsListBloc.add(FetchComments(widget.book.id));
    super.didChangeDependencies();
  }

  _openReview() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: _commentsListBloc,
        child: WriteReviewScreen(
          bookId: widget.book.id,
        ),
      ),
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
        actions: [],
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
                          Endpoints.imageURL(widget.book.coverImage),
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
                        BlocBuilder<PermissionBloc, PermissionState>(
                          cubit:
                              PermissionBloc(context.read<AccountRepository>())
                                ..add(CheckPermission()),
                          builder: (ctx, state) {
                            if (state is PermissionLoadedState &&
                                state.permission.commentPermission ==
                                    "READ_WRITE") {
                              return IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  size: 25,
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: _openReview,
                              );
                            }
                            return IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                size: 25,
                                color: Colors.black12,
                              ),
                              onPressed: () {},
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<CommentsListBloc, CommentsListState>(
                      cubit: _commentsListBloc,
                      builder: (ctx, state) {
                        if (state is LoadingCommentState) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (state is CommentLoadFailedState) {
                          return Center(
                            child: FailedReloadWidget(state.message, () {
                              _commentsListBloc
                                  .add(FetchComments(widget.book.id));
                            }),
                          );
                        }
                        if (state is CommentsLoadedState) {
                          return Column(
                            children: state.comments
                                .map((comment) => BlocProvider.value(
                                      child: ReviewTile(
                                        comment: comment,
                                        bookId: widget.book.id,
                                      ),
                                      value: _commentsListBloc,
                                    ))
                                .toList(),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
