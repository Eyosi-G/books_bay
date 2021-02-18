import 'package:equatable/equatable.dart';

import 'user.dart';

class Comment extends Equatable {
  String id;
  String comment;
  User postedBy;
  bool isOwnedByCurrentUser;
  DateTime date;
  Comment({
    this.id,
    this.comment,
    this.postedBy,
    this.isOwnedByCurrentUser = false,
    this.date,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as String,
      comment: json['comment'] as String,
      date: DateTime.parse(json['date']),
      postedBy: json['posted_by'] == null
          ? null
          : User.fromJson(json['posted_by'] as Map<String, dynamic>),
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': this.id,
        'comment': this.comment,
        'posted_by': this.postedBy?.toJson(),
      };

  @override
  List<Object> get props => [id, comment, postedBy, isOwnedByCurrentUser];
}
