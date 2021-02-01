/*

_id,
title,
is_best_seller,
description,
date_published,
author,
price,
pages,
cover,
ebook_name,
genre,


 */
import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  @JsonKey(name: 'is_best_seller')
  final bool isBestSeller;
  final String author;
  final double price;
  final String description;
  final double rating;
  final int pages;
  @JsonKey(name: 'cover')
  final String coverImage;
  final List<String> genre;
  final List<Comment> comments;
  Book(
      {this.id,
      this.description,
      this.title,
      this.price,
      this.author,
      this.coverImage,
      this.genre,
      this.isBestSeller,
      this.pages,
      this.rating,
      this.comments});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
