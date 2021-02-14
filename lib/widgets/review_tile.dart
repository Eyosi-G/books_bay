import 'package:books_bay/blocs/comments_list/comments_list_bloc.dart';
import 'package:books_bay/blocs/comments_list/comments_list_event.dart';
import 'package:books_bay/models/comment.dart';
import 'package:books_bay/widgets/write_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum Select { EDIT, DELETE }

class ReviewTile extends StatelessWidget {
  final Comment comment;
  final String bookId;
  ReviewTile({
    @required this.comment,
    @required this.bookId,
  });

  final commentStyle = TextStyle(
    color: Colors.black38,
    fontSize: 15,
  );
  final double width = 10;
  final deleteColor = Color(0xffCC0000);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            title: Text(
              '${comment.postedBy.username}',
            ),
            subtitle: Text(
              '${DateFormat.yMMMd().format(comment.date)}',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            trailing: !comment.isOwnedByCurrentUser
                ? null
                : PopupMenuButton<Object>(
                    onSelected: (selected) {
                      if (selected == Select.EDIT) {
                        Scaffold.of(context).showBottomSheet(
                          (_) => BlocProvider.value(
                            value: context.read<CommentsListBloc>(),
                            child: WriteReviewScreen(
                              comment: comment.comment,
                              commentId: comment.id,
                              edit: true,
                              bookId: bookId,
                            ),
                          ),
                          elevation: 10,
                          backgroundColor: Color(0xfff7f7e8),
                        );
                      } else if (selected == Select.DELETE) {
                        context.read<CommentsListBloc>().add(
                              DeleteComment(
                                bookId: bookId,
                                commentId: comment.id,
                              ),
                            );
                      }
                    },
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: width),
                              Text('Edit'),
                            ],
                          ),
                          value: Select.EDIT,
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: deleteColor,
                              ),
                              SizedBox(width: width),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: deleteColor,
                                ),
                              ),
                            ],
                          ),
                          value: Select.DELETE,
                        ),
                      ];
                    },
                  ),
          ),
          Text(
            '${comment.comment}',
            style: commentStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
