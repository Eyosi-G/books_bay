import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'library.dart';
import '../../models/models.dart';
import '../books_list/books_list_bloc.dart';
import '../books_list/books_list_event.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository libraryRepository;
  final BooksListBloc booksListBloc;
  LibraryBloc({@required this.libraryRepository, @required this.booksListBloc})
      : super(LibraryInitState());

  @override
  Stream<LibraryState> mapEventToState(LibraryEvent event) async* {
    if (event is FetchBooksEvent) {
      yield LibraryLoadingState();
      final books = await libraryRepository.fetchMyBooks();
      yield LibraryLoadedState(books);
    }
    if (event is AddBookEvent) {
      await libraryRepository.createBook(event.book);
      final books = await libraryRepository.fetchMyBooks();
      booksListBloc.add(FetchedBooks());
      yield LibraryLoadedState(books);
    }
    if (event is DeleteBookEvent) {
      await libraryRepository.deleteBook(event.bookId);
      final books = await libraryRepository.fetchMyBooks();
      booksListBloc.add(FetchedBooks());
      yield LibraryLoadedState(books);
    }
    if (event is UpdateBookEvent) {
      await libraryRepository.editBook(event.book, event.isFileSelected);
      final books = await libraryRepository.fetchMyBooks();
      booksListBloc.add(FetchedBooks());
      yield LibraryLoadedState(books);
    }
  }
}
