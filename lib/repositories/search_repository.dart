import 'package:books_bay/data_provider/data_providers.dart';
import 'package:books_bay/models/models.dart';

class SearchRepository {
  final SearchDataProvider searchDataProvider;
  SearchRepository(this.searchDataProvider);
  Future<List<Book>> search(String text) async {
    return await searchDataProvider.search(text);
  }
}
