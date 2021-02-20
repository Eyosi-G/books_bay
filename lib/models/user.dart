import 'package:equatable/equatable.dart';
import './permission.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;
  final Permission permission;
  User({this.email, this.password, this.username, this.id, this.permission});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      permission: Permission.fromJson(json["permissions"]));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'password': password,
        'permissions': permission?.toJson(),
      };

  @override
  List<Object> get props => [id, username, email, password];
}
