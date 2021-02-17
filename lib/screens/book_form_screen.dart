import 'dart:io';

import 'package:books_bay/blocs/library/library.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
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

  String _imageError = "";
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
        SizedBox(height: 10),
        Text(_imageError, style: TextStyle(color: Colors.red)),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _saveBookHandler() {
    if (_formKey.currentState.validate() && _book['image'].isNotEmpty) {
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
    setState(() {
      if (_book["image"].isEmpty) {
        _imageError = "please, upload an image";
      } else {
        _imageError = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 20,
    );
    final hintStyle = TextStyle(
      fontSize: 13,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Book Information',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              _addImageWidgetBuilder(),
              TextFormField(
                initialValue:
                    widget.bookArg.edit ? widget.bookArg.book.title : null,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Title',
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                  hintText: 'Title',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: TextStyle(
                  color: Colors.black54,
                ),
                textCapitalization: TextCapitalization.words,
                onSaved: (val) {
                  setState(() {
                    _book['title'] = val;
                  });
                },
                validator: (val) => val.isEmpty ? "Title can't be empty" : null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue:
                    widget.bookArg.edit ? widget.bookArg.book.author : null,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Author',
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                  hintText: 'Author',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                textCapitalization: TextCapitalization.words,
                onSaved: (val) {
                  setState(() {
                    _book['author'] = val;
                  });
                },
                style: TextStyle(
                  color: Colors.black54,
                ),
                validator: (val) =>
                    val.isEmpty ? "Author can't be empty" : null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.black54,
                ),
                initialValue: widget.bookArg.edit
                    ? widget.bookArg.book.description
                    : null,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Synopsis',
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                  hintText: 'Synopsis',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onSaved: (val) {
                  setState(() {
                    _book['description'] = val;
                  });
                },
                validator: (val) =>
                    val.isEmpty ? "Description can't be empty" : null,
              ),
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
