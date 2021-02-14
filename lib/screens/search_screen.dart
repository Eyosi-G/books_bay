import 'package:books_bay/blocs/search/search_bloc.dart';
import 'package:books_bay/blocs/search/search_event.dart';
import 'package:books_bay/blocs/search/search_state.dart';
import 'package:books_bay/data_provider/search_data_provider.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _searchBloc;
  @override
  void initState() {
    _searchBloc = SearchBloc(
      searchDataProvider: SearchDataProvider(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.black;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          autofocus: true,
          onChanged: (val) {
            _searchBloc.add(Search(val));
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            fillColor: Color(0xfff7f7e8),
            hintText: 'Search',
            isDense: true,
            border: InputBorder.none,
            filled: true,
            icon: Icon(
              Icons.search,
              color: color,
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.grey),
          ),
          cursorColor: color,
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Divider(),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              cubit: _searchBloc,
              builder: (ctx, state) {
                if (state is SearchLoadingState) {
                  return Center(child: Text('loading'));
                }
                if (state is SearchChanged) {
                  if (state.books.isEmpty) {
                    return Center(child: Text('Couldn\'t find the book'));
                  }
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          child: BookTileWidget(state.books[index]),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    BookDetailScreen(state.books[index])));
                          },
                        );
                      },
                      itemCount: state.books.length,
                      separatorBuilder: (ctx, index) {
                        return Divider(height: 10);
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
