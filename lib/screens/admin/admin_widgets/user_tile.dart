import 'package:books_bay/blocs/admin/admin.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/screens/admin/admin_screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTile extends StatelessWidget {
  final User user;
  UserTile(this.user);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) {
            return BlocProvider.value(
              child: UserPermissionScreen(user),
              value: context.read<AdminBloc>(),
            );
          }),
        ),
        leading: Image.asset(
          'assets/images/user.png',
          width: 50,
          height: 50,
        ),
        title: Text('${user.username}'),
        subtitle: Text('${user.email}'),
      ),
    );
  }
}
