import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;
  SearchBloc({@required this.searchRepository}) : super(InitialSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield* _search(event.text);
    }
  }

  Stream<SearchState> _search(String text) async* {
    yield SearchLoadingState();
    final books = await searchRepository.search(text);
    yield SearchChanged(books);
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 300)), transitionFn);
  }
}
