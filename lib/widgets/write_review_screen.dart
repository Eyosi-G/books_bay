import 'package:books_bay/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReviewScreen extends StatefulWidget {
  final String comment;
  final String commentId;
  final String bookId;
  final bool edit;
  WriteReviewScreen({
    this.bookId,
    this.commentId,
    this.comment,
    this.edit = false,
  });
  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  String _comment = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _saveHandler() {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (!widget.edit)
        context.read<CommentsListBloc>().add(
              AddComment(
                comment: _comment,
                bookId: widget.bookId,
              ),
            );
      if (widget.edit)
        context.read<CommentsListBloc>().add(
              EditComment(
                comment: _comment,
                commentId: widget.commentId,
                bookId: widget.bookId,
              ),
            );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black38,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _globalKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 60),
            Align(
              child: Text(
                'Write a review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: widget.edit ? widget.comment : null,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              minLines: 6,
              decoration: InputDecoration(
                border: focusBorder,
                filled: true,
                focusColor: Colors.black,
                focusedBorder: focusBorder,
              ),
              onSaved: (val) {
                setState(() {
                  _comment = val;
                });
              },
              validator: (val) => val.isEmpty ? "review is empty" : null,
            ),
            SizedBox(height: 10),
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Row(
                children: [
                  Spacer(),
                  OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    onPressed: _saveHandler,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
