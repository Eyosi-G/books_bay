import 'package:flutter/material.dart';
import '../widgets/category_lists_widget.dart';

class SearchScreen extends StatelessWidget {
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
            CategoryListsWidget(),
          ],
        ),
      ),
    );
  }
}
