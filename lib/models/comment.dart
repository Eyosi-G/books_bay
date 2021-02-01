import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  @JsonKey(name: '_id')
  final String id;
  final String comment;
  @JsonKey(name: 'posted_by')
  final User postedBy;
  Comment({this.id, this.comment, this.postedBy});
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
