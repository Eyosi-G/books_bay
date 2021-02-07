import 'package:books_bay/models/db_models/db_models.dart';

abstract class LibraryState {}

class InitialLibraryState extends LibraryState {}

class LoadingLibraryState extends LibraryState {}

class LibraryLoadedState extends LibraryState {
  final List<Download> downloads;
  LibraryLoadedState(this.downloads);
}
