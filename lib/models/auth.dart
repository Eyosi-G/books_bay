import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final String id;
  DateTime exp;
  Auth({this.id, this.token, this.exp}) {
    if (this.exp == null) this.exp = DateTime.now().add(Duration(hours: 1));
  }
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      token: json['token'],
    );
  }
  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      exp: DateTime.parse(map['exp']),
      id: map['id'],
      token: map['token'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'exp': exp.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [id, token, exp];
}
