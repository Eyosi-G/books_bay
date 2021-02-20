import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Permission extends Equatable {
  final String postPermission;
  final String commentPermission;
  Permission({@required this.commentPermission, @required this.postPermission});
  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      commentPermission: json["comment_permission"],
      postPermission: json["post_permission"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "comment_permission": commentPermission,
      "post_permission": postPermission,
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [postPermission, commentPermission];
}
