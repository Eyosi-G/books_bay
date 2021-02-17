import 'package:books_bay/blocs/blocs.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:books_bay/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;

  String _email = '';
  String _password = '';
  bool _isObscure = true;
  BuildContext _dialogContext;

  _createAccount() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  void didChangeDependencies() {
    _loginBloc = LoginBloc(
        loginRepository: context.read<LoginRepository>(),
        authRepository: context.read<AuthRepository>(),
        authBloc: context.read<AuthBloc>());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Navigator.of(_dialogContext).pop();
    _loginBloc.close();
    super.dispose();
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
    // ignore: close_sinks
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (ctx, state) async {
          if (state is LoginFailedState) {
            if (_dialogContext != null) Navigator.of(_dialogContext).pop();
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is LoginLoadingState) {
            await showDialog(
              context: context,
              builder: (_ctx) {
                _dialogContext = _ctx;
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 30),
                      Text('loading..'),
                    ],
                  ),
                );
              },
            );
          }
        },
        cubit: _loginBloc,
        builder: (ctx, state) {
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
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (val) {
                                _email = val;
                              },
                              validator: (val) {
                                return val.isEmpty
                                    ? "email can't be empty"
                                    : null;
                              },
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  labelStyle: labelStyle,
                                  hintStyle: hintStyle,
                                  hintText: 'Email',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              onSaved: (val) {
                                _password = val;
                              },
                              validator: (val) {
                                return val.isEmpty
                                    ? "password can't be empty"
                                    : null;
                              },
                              obscureText: _isObscure,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Password',
                                labelStyle: labelStyle,
                                hintStyle: hintStyle,
                                hintText: 'Password',
                                suffixIcon: _isObscure
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = false;
                                          });
                                        },
                                        icon: Icon(Icons.visibility_off),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = true;
                                          });
                                        },
                                        icon: Icon(Icons.visibility),
                                      ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                            Spacer(),
                            FlatButton(
                              minWidth: double.infinity,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  _loginBloc.add(
                                    AttemptedLogin(
                                      email: _email,
                                      password: _password,
                                    ),
                                  );
                                }
                              },
                              child: Text('Login'),
                              disabledColor: Colors.black26,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FlatButton(
                              minWidth: double.infinity,
                              onPressed: _createAccount,
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
        },
      ),
    );
  }
}
