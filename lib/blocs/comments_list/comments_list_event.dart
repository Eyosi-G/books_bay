import 'package:books_bay/models/comment.dart';
import 'package:flutter/foundation.dart';

abstract class CommentsListEvent {}

class FetchComments extends CommentsListEvent {
  final String bookId;
  FetchComments(this.bookId);
}

class AddComment extends CommentsListEvent {
  final String comment;
  final String bookId;
  AddComment({@required this.comment, @required this.bookId});
}

class EditComment extends CommentsListEvent {
  final String bookId;
  final String comment;
  final String commentId;
  EditComment({
    @required this.commentId,
    @required this.comment,
    @required this.bookId,
  });
}

class DeleteComment extends CommentsListEvent {
  final String bookId;
  final String commentId;
  DeleteComment({
    @required this.commentId,
    @required this.bookId,
  });
}
