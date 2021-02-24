import 'package:books_bay/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PermissionState extends Equatable {}

class InitialPermissionState extends PermissionState {
  @override
  List<Object> get props => [];
}

class PermissionLoadedState extends PermissionState {
  final Permission permission;
  PermissionLoadedState(this.permission);
  @override
  List<Object> get props => [permission];
}

class PermissionLoadingState extends PermissionState {
  @override
  List<Object> get props => [];
}
