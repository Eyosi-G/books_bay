import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../blocs.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository libraryRepository;
  final BooksListBloc booksListBloc;
  LibraryBloc({@required this.libraryRepository, @required this.booksListBloc})
      : super(LibraryInitState());

  @override
  Stream<LibraryState> mapEventToState(LibraryEvent event) async* {
    if (event is FetchBooksEvent) {
      try {
        yield LibraryLoadingState();
        final books = await libraryRepository.fetchMyBooks();
        yield LibraryLoadedState(books);
      } catch (e) {
        yield LibraryLoadingFailedState("Failed to Fetch My Posts");
      }
    }
    if (event is AddBookEvent) {
      try {
        await libraryRepository.createBook(event.book);
        final books = await libraryRepository.fetchMyBooks();
        booksListBloc.add(FetchedBooks());
        yield LibraryLoadedState(books);
      } catch (e) {
        yield LibraryLoadingFailedState("Failed to Create Post");
      }
    }
    if (event is DeleteBookEvent) {
      try {
        await libraryRepository.deleteBook(event.bookId);
        final books = await libraryRepository.fetchMyBooks();
        booksListBloc.add(FetchedBooks());
        yield LibraryLoadedState(books);
      } catch (e) {
        yield LibraryLoadingFailedState("Failed to Delete Post");
      }
    }
    if (event is UpdateBookEvent) {
      try {
        await libraryRepository.editBook(event.book, event.isFileSelected);
        final books = await libraryRepository.fetchMyBooks();
        booksListBloc.add(FetchedBooks());
        yield LibraryLoadedState(books);
      } catch (e) {
        yield LibraryLoadingFailedState("Failed to Update Post");
      }
    }
  }
}
