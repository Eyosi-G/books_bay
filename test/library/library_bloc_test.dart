import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLibraryRepository extends Mock implements LibraryRepository {}

class MockBooksListBloc extends Mock implements BooksListBloc {}

main() {
  MockLibraryRepository libraryRepository;
  MockBooksListBloc booksListBloc;
  LibraryBloc libraryBloc;

  setUp(() {
    libraryRepository = MockLibraryRepository();
    booksListBloc = MockBooksListBloc();
    libraryBloc = LibraryBloc(
        libraryRepository: libraryRepository, booksListBloc: booksListBloc);
  });

  tearDown(() {
    booksListBloc?.close();
    libraryBloc?.close();
  });

  group("Fetch My Posts", () {
    test("fetch my posts succeeded test", () {
      libraryBloc.add(FetchBooksEvent());
      final books = [Book(id: "1"), Book(id: "2")];
      when(libraryRepository.fetchMyBooks())
          .thenAnswer((realInvocation) => Future.value(books));
      expectLater(libraryBloc,
          emitsInOrder([LibraryLoadingState(), LibraryLoadedState(books)]));
    });

    test("fetch my posts failed test", () {
      libraryBloc.add(FetchBooksEvent());
      when(libraryRepository.fetchMyBooks())
          .thenAnswer((realInvocation) => Future.error(Exception()));
      expectLater(
          libraryBloc,
          emitsInOrder([
            LibraryLoadingState(),
            LibraryLoadingFailedState("Failed to Fetch My Posts")
          ]));
    });
  });

  group("Post Book", () {
    test("post book success test", () {
      libraryBloc.add(AddBookEvent(Book()));
      when(libraryRepository.createBook(Book()))
          .thenAnswer((realInvocation) => Future.value());
      expectLater(libraryBloc, emits(LibraryLoadedState(null)));
    });
    test("post book failed test", () {
      libraryBloc.add(AddBookEvent(Book()));
      when(libraryRepository.createBook(Book()))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      expectLater(libraryBloc,
          emits(LibraryLoadingFailedState("Failed to Create Post")));
    });
  });

  group("Delete My Post", () {
    test("delete book success", () {
      libraryBloc.add(DeleteBookEvent("2"));
      when(libraryRepository.deleteBook("2"))
          .thenAnswer((realInvocation) => Future.value());
      expectLater(libraryBloc, emits(LibraryLoadedState(null)));
    });
    test("delete book failed", () {
      libraryBloc.add(DeleteBookEvent("3"));
      when(libraryRepository.deleteBook("3"))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      expectLater(libraryBloc,
          emits(LibraryLoadingFailedState("Failed to Delete Post")));
    });
  });

  group("Update My Post", () {
    test("update book success", () {
      libraryBloc.add(UpdateBookEvent(book: Book(), isFileSelected: true));
      when(libraryRepository.editBook(Book(), true))
          .thenAnswer((realInvocation) => Future.value());
      expectLater(libraryBloc, emits(LibraryLoadedState(null)));
    });
    test("update book failed", () {
      libraryBloc.add(UpdateBookEvent(book: Book(), isFileSelected: true));
      when(libraryRepository.editBook(Book(), true))
          .thenAnswer((realInvocation) => Future.error(Exception()));
      expectLater(libraryBloc,
          emits(LibraryLoadingFailedState("Failed to Update Post")));
    });
  });
}
