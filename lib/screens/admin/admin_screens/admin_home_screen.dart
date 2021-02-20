import 'package:books_bay/blocs/admin/admin.dart';
import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/screens/admin/admin_widgets/user_tile.dart';
import 'package:books_bay/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Users',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Logout',
                  ),
                  value: 0,
                ),
              ];
            },
            onSelected: (val) {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          )
        ],
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (ctx, state) {
          if (state is FailedState) {
            return FailedReloadWidget(() {
              context.read<AdminBloc>().add(FetchUsers());
            });
          }
          if (state is UsersListLoaded) {
            if (state.users.length == 0) {
              return Center(
                child: Image.asset("assets/images/empty.png"),
              );
            }
            return ListView.builder(
              itemBuilder: (ctx, index) {
                return UserTile(state.users[index]);
              },
              itemCount: state.users.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
