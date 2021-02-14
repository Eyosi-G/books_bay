import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;
  User({this.email, this.password, this.username, this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        username: json['username'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'password': password,
      };

  @override
  List<Object> get props => [id, username, email, password];
}
