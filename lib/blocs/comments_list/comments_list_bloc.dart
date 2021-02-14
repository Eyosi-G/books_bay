import 'package:books_bay/models/comment.dart';
import 'package:books_bay/models/user.dart';
import 'package:books_bay/data_provider/auth_data_provider.dart';
import 'package:books_bay/data_provider/comment_data_provider.dart';
import 'package:books_bay/repositories/auth_repository.dart';
import 'package:books_bay/repositories/comment_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comments_list_event.dart';
import 'comments_list_state.dart';

class CommentsListBloc extends Bloc<CommentsListEvent, CommentsListState> {
  final CommentRepository commentRepository;
  CommentsListBloc({
    @required this.commentRepository,
  }) : super(InitialCommentState());

  @override
  Stream<CommentsListState> mapEventToState(CommentsListEvent event) async* {
    if (event is AddComment) {
      await commentRepository.addComment(
          comment: event.comment, bookId: event.bookId);
      final comments = await commentRepository.fetchComments(event.bookId);
      yield CommentsLoadedState(comments);
    }
    if (event is FetchComments) {
      yield LoadingCommentState();
      final comments = await commentRepository.fetchComments(event.bookId);
      yield CommentsLoadedState(comments);
    }
    if (event is EditComment) {
      await commentRepository.editComment(
        bookId: event.bookId,
        commentText: event.comment,
        commentId: event.commentId,
      );
      final comments = await commentRepository.fetchComments(event.bookId);
      yield CommentsLoadedState(comments);
    }
    if (event is DeleteComment) {
      await commentRepository.deleteComment(
          bookId: event.bookId, commentId: event.commentId);
      final comments = await commentRepository.fetchComments(event.bookId);
      yield CommentsLoadedState(comments);
    }
  }
}
