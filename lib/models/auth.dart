import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final String id;
  final String role;
  DateTime exp;
  Auth({this.id, this.token, this.exp, this.role}) {
    if (this.exp == null) this.exp = DateTime.now().add(Duration(hours: 1));
  }
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(id: json['id'], token: json['token'], role: json['role']);
  }
  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      exp: DateTime.parse(map['exp']),
      id: map['id'],
      token: map['token'],
      role: map["role"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'exp': exp.toIso8601String(),
      'role': role,
    };
  }

  @override
  List<Object> get props => [id, token, exp];
}
