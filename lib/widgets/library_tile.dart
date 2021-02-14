import 'package:flutter/material.dart';
import '../models/models.dart';
import '../constants.dart';
import '../blocs/library/library.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/screens.dart';

enum Select { EDIT, DELETE }

class LibraryTile extends StatelessWidget {
  final Book book;
  LibraryTile(this.book);
  _deleteBook(BuildContext context) async {
    final response = await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('You won\'t  be able to revert this!'),
            actions: [
              FlatButton(
                child: Text(
                  'Yes, delete it!',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        });
    if (response) {
      context.read<LibraryBloc>().add(DeleteBookEvent(book.id));
    }
  }

  _editBook(BuildContext context) {
    Navigator.of(context).pushNamed(
      BookFormScreen.routeName,
      arguments: BookArg(book: book, edit: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        title: Text(book.title),
        subtitle: Text(book.author),
        backgroundColor: Colors.black54,
        trailing: PopupMenuButton<Object>(
          onSelected: (selected) {
            if (selected == Select.DELETE) {
              _deleteBook(context);
            }
            if (selected == Select.EDIT) {
              _editBook(context);
            }
          },
          itemBuilder: (ctx) {
            return [
              PopupMenuItem(
                value: Select.EDIT,
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text('Edit'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: Select.DELETE,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ];
          },
        ),
      ),
      child: Image.network(
        Endpoints.imageURL(book.coverImage),
        fit: BoxFit.cover,
      ),
    );
    ;
  }
}
