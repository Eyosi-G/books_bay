import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class LibraryState extends Equatable {}

class LibraryLoadingState extends LibraryState {
  @override
  List<Object> get props => [];
}

class LibraryInitState extends LibraryState {
  @override
  List<Object> get props => [];
}

class LibraryLoadedState extends LibraryState {
  final List<Book> books;
  LibraryLoadedState(this.books);
  @override
  List<Object> get props => [books];
}

class LibraryLoadingFailedState extends LibraryState {
  final String message;
  LibraryLoadingFailedState(this.message);
  @override
  List<Object> get props => [message];
}
