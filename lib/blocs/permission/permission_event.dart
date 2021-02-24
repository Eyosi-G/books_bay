import 'package:equatable/equatable.dart';

abstract class PermissionEvent extends Equatable {}

class CheckPermission extends PermissionEvent {
  @override
  List<Object> get props => [];
}
