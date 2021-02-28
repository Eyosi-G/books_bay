import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBooksRepository extends Mock implements BooksRepository {}

main() {
  MockBooksRepository booksRepository;
  BooksListBloc booksListBloc;

  setUp(() {
    booksRepository = MockBooksRepository();
    booksListBloc = BooksListBloc(booksRepository);
  });
  tearDown(() {
    booksListBloc?.close();
  });

  test("fetch books state successful test", () {
    final books = [
      Book(id: "5", isBestSeller: false),
      Book(id: "7", isBestSeller: true)
    ];
    when(booksRepository.fetchBooks()).thenAnswer((_) => Future.value(books));
    expectLater(
        booksListBloc,
        emitsInOrder([
          BooksListLoadingState(),
          BooksListFetchedState(
            books: books,
            bestSellers: [Book(id: "7", isBestSeller: true)],
          ),
        ]));
    booksListBloc.add(FetchedBooks());
  });

  test("fetch books failed state", () {
    when(booksRepository.fetchBooks())
        .thenAnswer((_) => Future.error(Exception()));
    expectLater(
        booksListBloc,
        emitsInOrder([
          BooksListLoadingState(),
          BooksListFetchFailedState("Failed Loading Books"),
        ]));
    booksListBloc.add(FetchedBooks());
  });
}
