import 'dart:io';

import 'package:books_bay/blocs/library/library.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
import './books_route.dart';
import './screens.dart';
import '../constants.dart';

class BookFormScreen extends StatefulWidget {
  static const routeName = "book_form_screen";
  final BookArg bookArg;
  BookFormScreen({@required this.bookArg});
  @override
  _BookFormScreenState createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  Map<String, dynamic> _book = {
    "isBestSeller": false,
    "image": "",
    "title": "",
    "author": "",
    "description": "",
  };
  File _image;
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  void initState() {
    if (widget.bookArg.edit) {
      _book["isBestSeller"] = widget.bookArg.book.isBestSeller;
      _book["image"] = widget.bookArg.book.coverImage;
    }
    super.initState();
  }

  Widget get _imagePreview {
    if (widget.bookArg.edit && _image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
        width: 140,
        height: 140,
      );
    } else if (widget.bookArg.edit && _image == null) {
      return Image.network(
        Endpoints.imageURL(widget.bookArg.book.coverImage),
        fit: BoxFit.cover,
        width: 140,
        height: 140,
      );
    } else if (!widget.bookArg.edit && _image != null) {
      return Image.file(
        _image,
        fit: BoxFit.cover,
        width: 140,
        height: 140,
      );
    }
    return null;
  }

  _addImageWidgetBuilder() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _imagePreview,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
                  ),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.getImage(source: ImageSource.gallery);
                    if (pickedFile != null)
                      setState(() {
                        _book['image'] = pickedFile.path;
                        _image = File(pickedFile.path);
                      });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildDescriptionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text('Description'),
        SizedBox(height: 2),
        TextFormField(
          initialValue:
              widget.bookArg.edit ? widget.bookArg.book.description : null,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          minLines: 6,
          decoration: InputDecoration(
            fillColor: Color(0xfff7f7e8),
            filled: true,
            focusColor: Colors.black,
            border: OutlineInputBorder(),
          ),
          onSaved: (val) {
            _book['description'] = val;
          },
        ),
      ],
    );
  }

  _saveBookHandler() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.bookArg.edit) {
        final book = Book(
          isBestSeller: _book['isBestSeller'],
          coverImage: _book['image'],
          description: _book['description'],
          author: _book['author'],
          title: _book['title'],
          id: widget.bookArg.book.id,
        );
        context
            .read<LibraryBloc>()
            .add(UpdateBookEvent(book: book, isFileSelected: _image != null));
      } else {
        final book = Book(
          isBestSeller: _book['isBestSeller'],
          coverImage: _book['image'],
          description: _book['description'],
          author: _book['author'],
          title: _book['title'],
        );
        context.read<LibraryBloc>().add(AddBookEvent(book));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              _addImageWidgetBuilder(),
              Text('Title'),
              SizedBox(height: 2),
              TextFormField(
                initialValue:
                    widget.bookArg.edit ? widget.bookArg.book.title : null,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Color(0xfff7f7e8),
                  filled: true,
                ),
                onSaved: (val) {
                  setState(() {
                    _book['title'] = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('Author'),
              SizedBox(height: 2),
              TextFormField(
                initialValue:
                    widget.bookArg.edit ? widget.bookArg.book.author : null,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Color(0xfff7f7e8),
                  filled: true,
                ),
                onSaved: (val) {
                  setState(() {
                    _book['author'] = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              _buildDescriptionArea(),
              Row(
                children: [
                  Checkbox(
                      value: _book['isBestSeller'],
                      onChanged: (val) {
                        setState(() {
                          _book['isBestSeller'] = val;
                        });
                      }),
                  Text('Is Best Seller'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton.icon(
                    onPressed: _saveBookHandler,
                    icon: Icon(Icons.save),
                    label: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
