// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['_id'] as String,
    description: json['description'] as String,
    bookName: json['ebook_name'] as String,
    title: json['title'] as String,
    price: (json['price'] as num)?.toDouble(),
    author: json['author'] as String,
    coverImage: json['cover'] as String,
    genre: (json['genre'] as List)?.map((e) => e as String)?.toList(),
    isBestSeller: json['is_best_seller'] as bool,
    pages: json['pages'] as int,
    rating: (json['rating'] as num)?.toDouble(),
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'is_best_seller': instance.isBestSeller,
      'author': instance.author,
      'price': instance.price,
      'description': instance.description,
      'rating': instance.rating,
      'ebook_name': instance.bookName,
      'pages': instance.pages,
      'cover': instance.coverImage,
      'genre': instance.genre,
      'comments': instance.comments?.map((e) => e?.toJson())?.toList(),
    };
