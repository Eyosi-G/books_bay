import 'package:books_bay/blocs/auth/auth_bloc.dart';
import 'package:books_bay/blocs/auth/auth_event.dart';
import 'package:books_bay/blocs/login/login_bloc.dart';
import 'package:books_bay/blocs/login/login_event.dart';
import 'package:books_bay/blocs/login/login_state.dart';
import 'package:books_bay/models/user.dart';
import 'package:books_bay/repository/login_data_provider.dart';
import 'package:books_bay/widgets/bottom_navigation_bar_widget.dart';
import 'package:books_bay/widgets/custom_app_bar.dart';
import 'package:books_bay/widgets/images_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;

  String _email = '';
  String _password = '';
  AutovalidateMode _formChanged = AutovalidateMode.disabled;

  InputDecoration _decoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: TextStyle(
        fontSize: 12,
      ),
    );
  }

  _onFormChanged() {
    if (_formChanged == AutovalidateMode.always) return;
    setState(() {
      _formChanged = AutovalidateMode.always;
    });
  }

  final textFormStyle = TextStyle(
    fontSize: 12,
    color: Colors.black54,
  );

  @override
  void didChangeDependencies() {
    _loginBloc = LoginBloc(LoginDataProvider());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (ctx, state) async {
          if (state is LoginFailedState) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is LoginSucceedState) {
            BlocProvider.of<AuthBloc>(ctx).add(CheckAuthStatus());
          }
        },
        cubit: _loginBloc,
        builder: (ctx, state) {
          if (state is LoginSucceedState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                height: height,
                child: Column(
                  children: [
                    Expanded(child: ImagesSliderWidget()),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25,
                        ),
                        child: Form(
                          key: _formKey,
                          onChanged: _onFormChanged,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    _decoration('Email', 'abebe@gmail.com'),
                                style: textFormStyle,
                                onSaved: (val) {
                                  _email = val;
                                },
                                autovalidateMode: _formChanged,
                                validator: (val) {
                                  return val.isEmpty
                                      ? "email can't be empty"
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration:
                                    _decoration('Password', '. . . . . . . .'),
                                obscureText: true,
                                style: textFormStyle,
                                onSaved: (val) {
                                  _password = val;
                                },
                                autovalidateMode: _formChanged,
                                validator: (val) {
                                  return val.isEmpty
                                      ? "password can't be empty"
                                      : null;
                                },
                              ),
                              Spacer(),
                              FlatButton(
                                minWidth: double.infinity,
                                color: Theme.of(context).primaryColor,
                                onPressed: _formChanged ==
                                        AutovalidateMode.always
                                    ? () async {
                                        if (true ||
                                            _formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          _loginBloc.add(
                                            AttemptedLogin(
                                              email: _email,
                                              password: _password,
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                child: Text('Login'),
                                disabledColor: Colors.black26,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton(
                                minWidth: double.infinity,
                                onPressed: () {},
                                child: Text('create account'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
