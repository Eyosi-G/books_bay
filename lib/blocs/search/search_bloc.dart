import 'package:books_bay/data_provider/search_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDataProvider searchDataProvider;
  SearchBloc({@required this.searchDataProvider}) : super(InitialSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield* _search(event.text);
    }
  }

  Stream<SearchState> _search(String text) async* {
    yield SearchLoadingState();

    final books = await searchDataProvider.search(filter: "", text: text);
    yield SearchChanged(books);
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 300)), transitionFn);
  }
}
