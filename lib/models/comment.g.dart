// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['_id'] as String,
    comment: json['comment'] as String,
    postedBy: json['posted_by'] == null
        ? null
        : User.fromJson(json['posted_by'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'comment': instance.comment,
      'posted_by': instance.postedBy?.toJson(),
    };
