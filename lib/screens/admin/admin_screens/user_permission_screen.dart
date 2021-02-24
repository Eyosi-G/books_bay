import 'package:books_bay/blocs/admin/admin.dart';
import 'package:books_bay/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens.dart';

enum CommentPermission {
  READ_ONLY,
  READ_WRITE,
}
enum PostPermission {
  READ_ONLY,
  READ_WRITE,
}

class UserPermissionScreen extends StatefulWidget {
  final User user;
  UserPermissionScreen(this.user);
  static const routeName = "permission_screen";
  @override
  _UserPermissionScreenState createState() => _UserPermissionScreenState();
}

class _UserPermissionScreenState extends State<UserPermissionScreen> {
  var _postPermission = PostPermission.READ_WRITE;
  var _commentPermission = CommentPermission.READ_WRITE;

  @override
  void initState() {
    print(widget.user.permission.toJson());
    setState(() {
      if (widget.user.permission.postPermission == "READ_ONLY") {
        _postPermission = PostPermission.READ_ONLY;
      }
      if (widget.user.permission.commentPermission == "READ_ONLY") {
        _commentPermission = CommentPermission.READ_ONLY;
      }
    });
    super.initState();
  }

  _save() {
    String userId = widget.user.id;
    final permission = Permission(
      commentPermission: _commentPermission == CommentPermission.READ_ONLY
          ? "READ_ONLY"
          : "READ_WRITE",
      postPermission: _postPermission == PostPermission.READ_ONLY
          ? "READ_ONLY"
          : "READ_WRITE",
    );
    context.read<AdminBloc>().add(UpdateUserPermission(
          permission: permission,
          userId: userId,
        ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.check),
            label: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  '${widget.user.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('${widget.user.email}')
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Permission',
                    style: titleStyle,
                  ),
                  SizedBox(height: 20),
                  RadioListTile(
                      value: PostPermission.READ_ONLY,
                      title: Text("Read Only"),
                      groupValue: _postPermission,
                      onChanged: (val) {
                        setState(() {
                          _postPermission = val;
                        });
                      }),
                  RadioListTile(
                      value: PostPermission.READ_WRITE,
                      title: Text("Read Write"),
                      groupValue: _postPermission,
                      onChanged: (val) {
                        setState(() {
                          _postPermission = val;
                        });
                      }),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment Permission',
                    style: titleStyle,
                  ),
                  SizedBox(height: 20),
                  RadioListTile(
                      value: CommentPermission.READ_ONLY,
                      title: Text("Read Only"),
                      groupValue: _commentPermission,
                      onChanged: (val) {
                        setState(() {
                          _commentPermission = val;
                        });
                      }),
                  RadioListTile(
                      value: CommentPermission.READ_WRITE,
                      title: Text("Read Write"),
                      groupValue: _commentPermission,
                      onChanged: (val) {
                        setState(() {
                          _commentPermission = val;
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
