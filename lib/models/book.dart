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
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final bool isBestSeller;
  final String author;
  final String description;
  final String coverImage;
  Book({
    this.id,
    this.description,
    this.title,
    this.author,
    this.coverImage,
    this.isBestSeller,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["_id"],
      title: json["title"],
      author: json["author"],
      description: json["description"],
      coverImage: json["cover"],
      isBestSeller: json["isBestSeller"] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "author": author,
      "description": description,
      "cover": coverImage,
      "isBestSeller": isBestSeller,
    };
  }

  @override
  List<Object> get props =>
      [id, title, author, description, coverImage, isBestSeller];
}
