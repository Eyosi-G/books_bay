import 'package:books_bay/data_provider/comment_data_provider.dart';
import 'package:books_bay/models/comment.dart';
import 'package:flutter/foundation.dart';
import '../data_provider/auth_data_provider.dart';

class CommentRepository {
  final CommentDataProvider commentDataProvider;
  final AuthDataProvider authDataProvider;
  CommentRepository({
    @required this.commentDataProvider,
    @required this.authDataProvider,
  });
  Future<List<Comment>> fetchComments(String bookId) async {
    final auth = await authDataProvider.getAuth();
    final comments = await commentDataProvider.fetchComments(bookId);
    return comments.map((comment) {
      return Comment(
        id: comment.id,
        comment: comment.comment,
        postedBy: comment.postedBy,
        isOwnedByCurrentUser: auth.id == comment.postedBy.id,
        date: comment.date,
      );
    }).toList();
  }

  Future addComment({@required String comment, @required String bookId}) async {
    final auth = await authDataProvider.getAuth();
    await commentDataProvider.createComment(
      token: auth.token,
      comment: comment,
      bookId: bookId,
    );
  }

  Future editComment({
    @required String bookId,
    @required String commentText,
    @required String commentId,
  }) async {
    final auth = await authDataProvider.getAuth();
    await commentDataProvider.editComment(
      token: auth.token,
      bookId: bookId,
      commentText: commentText,
      commentId: commentId,
    );
  }

  Future deleteComment({
    @required String bookId,
    @required String commentId,
  }) async {
    final auth = await authDataProvider.getAuth();

    await commentDataProvider.deleteComment(
      bookId: bookId,
      commentId: commentId,
      token: auth.token,
    );
  }
}
