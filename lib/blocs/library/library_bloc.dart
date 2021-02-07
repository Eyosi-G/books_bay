import 'package:bloc/bloc.dart';
import 'package:books_bay/db_provider/database_provider.dart';

import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(InitialLibraryState());

  @override
  Stream<LibraryState> mapEventToState(LibraryEvent event) async* {
    if (event is FetchLibraryBooksEvent) {
      yield LoadingLibraryState();
      final downloads = await DatabaseProvider().retrieveAll();
      yield LibraryLoadedState(downloads);
    }
  }
}
