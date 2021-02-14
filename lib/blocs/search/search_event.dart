abstract class SearchEvent {}

class Search extends SearchEvent {
  final String text;
  Search(this.text);
}
