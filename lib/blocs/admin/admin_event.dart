import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AdminEvent extends Equatable {}

class FetchUsers extends AdminEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserPermission extends AdminEvent {
  final Permission permission;
  final String userId;
  UpdateUserPermission({@required this.permission, @required this.userId});
  @override
  List<Object> get props => [userId, permission];
}
