import 'package:books_bay/blocs/account/account.dart';
import 'package:books_bay/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountEditWidget extends StatefulWidget {
  final User user;
  AccountEditWidget(this.user);

  @override
  _AccountEditWidgetState createState() => _AccountEditWidgetState();
}

class _AccountEditWidgetState extends State<AccountEditWidget> {
  final Map<String, String> _formData = {
    "username": "",
  };
  GlobalKey<FormState> _globalKey = GlobalKey();
  _saveEditAccount(BuildContext context) {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      final user = User(
        username: _formData["username"],
      );
      context.read<AccountBloc>().add(EditAccountEvent(user));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(
      fontWeight: FontWeight.w600,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _globalKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text('Edit Account Information'),
            SizedBox(height: 20),
            Text('UserName', style: title),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: TextFormField(
                initialValue: widget.user.username,
                validator: (val) => val.isEmpty ? '' : null,
                onSaved: (val) => _formData["username"] = val,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () => _saveEditAccount(context),
                  color: Theme.of(context).primaryColor,
                  child: Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
