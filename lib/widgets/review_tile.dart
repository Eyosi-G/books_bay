import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'widgets.dart';

enum SelectOption { EDIT, DELETE }

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
                      if (selected == SelectOption.EDIT) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<CommentsListBloc>(),
                            child: WriteReviewScreen(
                              comment: comment.comment,
                              commentId: comment.id,
                              edit: true,
                              bookId: bookId,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          isScrollControlled: true,
                        );
                      } else if (selected == SelectOption.DELETE) {
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
                          value: SelectOption.EDIT,
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
                          value: SelectOption.DELETE,
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
