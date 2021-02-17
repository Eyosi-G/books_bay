import 'package:books_bay/blocs/account/account.dart';
import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/repositories/account_repository.dart';
import 'package:books_bay/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SettingSelect { DELETE_ACCOUNT }

class SettingScreen extends StatefulWidget {
  static const routeName = "setting_sceen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AccountBloc _accountBloc;
  initState() {
    _accountBloc = AccountBloc(
        accountRepository: context.read<AccountRepository>(),
        authbloc: context.read<AuthBloc>())
      ..add(FetchAccountEvent());
    super.initState();
  }

  dispose() {
    _accountBloc.close();
    super.dispose();
  }

  Future _deleteAccount() async {
    final response = await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('You won\'t  be able to revert this action!'),
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
      _accountBloc.add(DeleteAccountEvent());
    }
  }

  _showEditScreen(BuildContext context) async {
    if (_accountBloc.state is AccountFetchedState) {
      final user = (_accountBloc.state as AccountFetchedState).user;
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => BlocProvider.value(
          child: AccountEditWidget(user),
          value: _accountBloc,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showEditScreen(context),
            icon: Icon(Icons.edit),
          ),
          PopupMenuButton(
            onSelected: (selected) async {
              if (selected == SettingSelect.DELETE_ACCOUNT) {
                await _deleteAccount();
                Navigator.of(context).pop();
              }
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Terminate Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  value: SettingSelect.DELETE_ACCOUNT,
                )
              ];
            },
          )
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        cubit: _accountBloc,
        builder: (ctx, state) {
          print(state);
          if (state is LoadingAccountState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AccountFailedState) {
            return FailedReloadWidget(() {
              _accountBloc.add(FetchAccountEvent());
            });
          }
          if (state is AccountFetchedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/user.png')),
                Text(
                  '${state.user.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${state.user.email}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
