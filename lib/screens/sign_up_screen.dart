import 'package:books_bay/blocs/register/register.dart';
import 'package:books_bay/models/models.dart';
import 'package:books_bay/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "sigup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Map<String, String> _inputs = {
    "username": "",
    "email": "",
    "password": "",
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObscure = true;
  RegisterBloc _registerBloc;
  BuildContext _dialogContext;

  @override
  void initState() {
    _registerBloc = RegisterBloc(context.read<AccountRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _registerBloc.close();
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
    final double height = 10;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'User Register',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/user.png',
                  height: 150,
                )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'UserName',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          hintText: 'UserName',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onSaved: (val) {
                          setState(() {
                            _inputs["username"] = val;
                          });
                        },
                        validator: (val) =>
                            val.isEmpty ? "Incorrect Username" : null,
                      ),
                      SizedBox(height: height),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Email',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          hintText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onSaved: (val) {
                          setState(() {
                            _inputs["email"] = val;
                          });
                        },
                        validator: (val) => val.isEmpty || !val.contains("@")
                            ? "Incorrect Email"
                            : null,
                      ),
                      SizedBox(height: height),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Password',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          hintText: 'Password',
                          helperText: 'password can\'t be < 8',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        ),
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        obscureText: _isObscure,
                        onSaved: (val) {
                          setState(() {
                            _inputs["password"] = val;
                          });
                        },
                        validator: (val) =>
                            val.length < 8 ? "Incorrect Password" : null,
                      ),
                      SizedBox(height: height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                final user = User(
                                  username: _inputs["username"],
                                  email: _inputs["email"],
                                  password: _inputs["password"],
                                );
                                _registerBloc.add(Register(user));
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text('Confirm'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (ctx, state) async {
                          if (state is RegisterLoadingState) {
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
                          if (_dialogContext != null &&
                                  state is RegisterSuccessfulState ||
                              state is RegisterFailedState) {
                            Navigator.of(_dialogContext).pop();
                          }
                        },
                        cubit: _registerBloc,
                        builder: (_, state) {
                          if (state is RegisterSuccessfulState) {
                            return Text(
                              'Successfully Registered !',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          } else if (state is RegisterFailedState) {
                            return Text(
                              '${state.message}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
