import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'comments_list.dart';

class CommentsListBloc extends Bloc<CommentsListEvent, CommentsListState> {
  final CommentRepository commentRepository;
  CommentsListBloc({
    @required this.commentRepository,
  }) : super(InitialCommentState());

  @override
  Stream<CommentsListState> mapEventToState(CommentsListEvent event) async* {
    if (event is AddComment) {
      try {
        await commentRepository.addComment(
            comment: event.comment, bookId: event.bookId);
        final comments = await commentRepository.fetchComments(event.bookId);
        yield CommentsLoadedState(comments);
      } catch (e) {
        yield CommentLoadFailedState("Adding Comment Failed");
      }
    }
    if (event is FetchComments) {
      try {
        yield LoadingCommentState();
        final comments = await commentRepository.fetchComments(event.bookId);
        yield CommentsLoadedState(comments);
      } catch (e) {
        yield CommentLoadFailedState("Fetching Comments Failed");
      }
    }
    if (event is EditComment) {
      try {
        await commentRepository.editComment(
          bookId: event.bookId,
          commentText: event.comment,
          commentId: event.commentId,
        );
        final comments = await commentRepository.fetchComments(event.bookId);
        yield CommentsLoadedState(comments);
      } catch (e) {
        yield CommentLoadFailedState("Editing Comment Failed");
      }
    }
    if (event is DeleteComment) {
      try {
        await commentRepository.deleteComment(
            bookId: event.bookId, commentId: event.commentId);
        final comments = await commentRepository.fetchComments(event.bookId);
        yield CommentsLoadedState(comments);
      } catch (e) {
        yield CommentLoadFailedState("Deleting Comment Failed");
      }
    }
  }
}
