import 'package:books_bay/models/comment.dart';

abstract class CommentsListState {}

class InitialCommentState extends CommentsListState {}

class LoadingCommentState extends CommentsListState {}

class CommentsLoadedState extends CommentsListState {
  final List<Comment> comments;
  CommentsLoadedState(this.comments);
}

class CommentLoadFailedState extends CommentsListState {
  final String message;
  CommentLoadFailedState(this.message);
}
