import 'package:books_bay/models/comment.dart';
import 'package:equatable/equatable.dart';

abstract class CommentsListState extends Equatable {}

class InitialCommentState extends CommentsListState {
  @override
  List<Object> get props => [];
}

class LoadingCommentState extends CommentsListState {
  @override
  List<Object> get props => [];
}

class CommentsLoadedState extends CommentsListState {
  final List<Comment> comments;
  CommentsLoadedState(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentLoadFailedState extends CommentsListState {
  final String message;
  CommentLoadFailedState(this.message);

  @override
  List<Object> get props => [message];
}
