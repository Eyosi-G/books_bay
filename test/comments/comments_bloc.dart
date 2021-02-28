import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

main() {
  MockCommentRepository commentRepository;
  CommentsListBloc commentsListBloc;
  setUp(() {
    commentRepository = MockCommentRepository();
    commentsListBloc = CommentsListBloc(commentRepository: commentRepository);
  });
  tearDown(() {
    commentsListBloc?.close();
  });

  group("Fetch Comments", () {
    test("fetching comment success", () {
      final comments = [Comment(id: "_1"), Comment(id: "_2")];
      when(commentRepository.fetchComments("1"))
          .thenAnswer((realInvocation) => Future.value(comments));
      commentsListBloc.add(FetchComments("1"));
      expectLater(
        commentsListBloc,
        emitsInOrder([
          LoadingCommentState(),
          CommentsLoadedState(comments),
        ]),
      );
    });

    test("fetching comment failed", () {
      when(commentRepository.fetchComments("_2"))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      expectLater(
        commentsListBloc,
        emitsInOrder([
          LoadingCommentState(),
          CommentLoadFailedState("Fetching Comments Failed"),
        ]),
      );
      commentsListBloc.add(FetchComments("_2"));
    });
  });

  group("Add Comment", () {
    test("adding comment success", () {
      when(commentRepository.addComment(comment: "nice!", bookId: "1"))
          .thenAnswer((realInvocation) => Future.value());
      commentsListBloc.add(AddComment(comment: "nice!", bookId: "1"));
      expectLater(
        commentsListBloc,
        emitsInOrder([
          CommentsLoadedState(null),
        ]),
      );
    });

    test("adding comment failed", () {
      when(commentRepository.addComment(comment: "nice!", bookId: "1"))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      commentsListBloc.add(AddComment(comment: "nice!", bookId: "1"));
      expectLater(
        commentsListBloc,
        emits(CommentLoadFailedState("Adding Comment Failed")),
      );
    });
  });

  group("Editing Comment", () {
    test("editing comment success", () {
      when(commentRepository.editComment(
              bookId: "1", commentText: "holla", commentId: "_1"))
          .thenAnswer((realInvocation) => Future.value());
      commentsListBloc
          .add(EditComment(commentId: "1", comment: "holla", bookId: "_1"));
      expectLater(
        commentsListBloc,
        emits(CommentsLoadedState(null)),
      );
    });
    test("editing comment failed", () {
      when(commentRepository.editComment(
              bookId: "1", commentText: "holla", commentId: "_1"))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      commentsListBloc
          .add(EditComment(commentId: "1", comment: "holla", bookId: "_1"));
      expectLater(
        commentsListBloc,
        emits(CommentLoadFailedState("Editing Comment Failed")),
      );
    });
  });
}
