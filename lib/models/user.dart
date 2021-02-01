import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String email;
  final String password;
  User({this.email, this.password, this.username, this.id});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

//email,username,password,id
