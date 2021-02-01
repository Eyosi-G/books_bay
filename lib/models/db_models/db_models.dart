class BookDB {
  final String id;
  final String description;
  final String title;
  final double price;
  final String coverImage;
  final bool isBestSeller;
  final int pages;
  final double rating;
  final String author;

  BookDB({
    this.id,
    this.description,
    this.title,
    this.price,
    this.author,
    this.coverImage,
//    this.genre,
    this.isBestSeller,
    this.pages,
    this.rating,
//    this.comments,
  });
  factory BookDB.fromMap(Map<String, dynamic> map) {
    return BookDB(
      id: map['id'],
      rating: map['rating'],
      description: map['description'],
      price: map['price'],
      title: map['title'],
      author: map['author'],
      coverImage: map['coverImage'],
      isBestSeller: (map['isBestSeller'] as String) == 'true',
      pages: map['pages'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'price': price,
      'coverImage': coverImage,
      'isBestSeller': isBestSeller.toString(),
      'pages': pages,
      'rating': rating,
      'author': author,
    };
  }
}

class GenreDB {
  final int id;
  final String genre;
  final String bookId;
  GenreDB({this.id, this.genre, this.bookId});
  factory GenreDB.fromMap(Map<String, dynamic> map) {
    return GenreDB(
      id: map['id'],
      genre: map['genre'],
      bookId: map['book_id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'genre': genre,
      'book_id': bookId,
    };
  }
}

class UserDB {
  final String id;
  final String name;
  UserDB({this.id, this.name});
  factory UserDB.fromMap(Map<String, dynamic> map) {
    return UserDB(
      id: map['id'],
      name: map['name'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CommentDB {
  final String comment;
  final String id;
  final String userId;
  final String bookId;
  CommentDB({this.id, this.comment, this.userId, this.bookId});
  factory CommentDB.fromMap(Map<String, dynamic> map) {
    return CommentDB(
      bookId: map['book_id'],
      comment: map['comment'],
      userId: map['user_id'],
      id: map['id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comment': comment,
      'user_id': userId,
      'book_id': bookId,
    };
  }
}
