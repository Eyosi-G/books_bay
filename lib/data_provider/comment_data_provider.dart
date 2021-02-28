import 'dart:convert';

import 'package:books_bay/models/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../constants.dart';

class CommentDataProvider {
  Future<List<Comment>> fetchComments(String bookId) async {
    final client = Client();
    final response = await client.get(Endpoints.getComments(bookId), headers: {
      'content-type': 'application/json',
    }).timeout(Duration(seconds: 10));
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('fetching comments failed');
    }
    final jsonComments = json.decode(response.body) as List;
    final comments = jsonComments
        .map((jsonComment) => Comment.fromJson(jsonComment))
        .toList();
    return comments;
  }

  Future deleteComment({
    @required String bookId,
    @required String commentId,
    @required String token,
  }) async {
    final client = Client();
    final response = await client.delete(
      Endpoints.deleteComment(bookId, commentId),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('deleting comment failed');
    }
  }

  Future createComment(
      {@required String token,
      @required String comment,
      @required String bookId}) async {
    final client = Client();
    final response = await client.post(Endpoints.createComment,
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode({
          'comment': comment,
          'book_id': bookId,
        }));
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('creating comment failed');
    }
  }

  Future editComment({
    @required String token,
    @required String bookId,
    @required String commentText,
    @required String commentId,
  }) async {
    final client = Client();
    final response = await client.put(
      Endpoints.updateComment,
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: json.encode({
        "book_id": bookId,
        "comment": commentText,
        "comment_id": commentId,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('editing comment failed');
    }
  }
}
