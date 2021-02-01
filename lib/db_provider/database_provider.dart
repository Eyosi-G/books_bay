//import 'dart:io';
//
//import 'package:books_bay/models/book.dart';
//import 'package:books_bay/models/comment.dart';
//import 'package:books_bay/models/db_models/db_models.dart';
//import 'package:flutter/foundation.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:sqflite/sqflite.dart';
//
//Future _create(Database db, int version) async {
//  await db.execute("""
//            CREATE TABLE Book (
//              id TEXT PRIMARY KEY,
//              description TEXT,
//              title TEXT,
//              price DOUBLE,
//              coverImage TEXT,
//              isBestSeller BOOLEAN,
//              pages INTEGER,
//              rating DOUBLE,
//              author TEXT
//            )""");
//
//  await db.execute("""
//            CREATE TABLE Genre (
//              id INTEGER PRIMARY KEY,
//              genre TEXT NOT NULL UNIQUE,
//              book_id TEXT,
//              FOREIGN KEY (book_id) REFERENCES Book(id)
//              ON DELETE CASCADE ON UPDATE CASCADE
//            )""");
//  await db.execute("""
//            CREATE TABLE User (
//              id TEXT PRIMARY KEY,
//              name TEXT NOT NULL
//            )""");
//  await db.execute("""
//            CREATE TABLE Comment (
//              id TEXT PRIMARY KEY,
//              comment TEXT NOT NULL,
//              user_id TEXT,
//              book_id TEXT,
//              FOREIGN KEY (user_id) REFERENCES User(id)
//              ON DELETE CASCADE ON UPDATE CASCADE
//              FOREIGN KEY (book_id) REFERENCES Book(id)
//              ON DELETE CASCADE ON UPDATE CASCADE
//            )""");
//}
//
//class DatabaseProvider {
//  Database _db;
//
//  DatabaseProvider._();
//  static final _instance = DatabaseProvider._();
//  factory DatabaseProvider() {
//    return _instance;
//  }
//  Future<Database> get database async {
//    if (_db != null) {
//      return _db;
//    }
//    _db = await init();
//    return _db;
//  }
//
//  Future<Database> init() async {
//    Directory path = await getApplicationDocumentsDirectory();
//    String dbPath = join(path.path, "books_bay.db");
//    print('database created');
//    return await openDatabase(
//      dbPath,
//      version: 1,
//      onCreate: _create,
//    );
//  }
//
//  dropTables() async {
//    final db = await database;
//    await db.execute('drop table Book');
//  }
//
//  Future _insertBook(BookDB book) async {
//    final db = await database;
//    await db.insert(
//      'Book',
//      book.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.ignore,
//    );
//  }
//
//  Future _insertGenre(GenreDB genre) async {
//    final db = await database;
//    await db.insert(
//      'Genre',
//      genre.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.ignore,
//    );
//  }
//
//  Future _insertUser(UserDB user) async {
//    final db = await database;
//    await db.insert(
//      'User',
//      user.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.ignore,
//    );
//  }
//
//  Future _insertComment(CommentDB comment) async {
//    final db = await database;
//    await db.insert(
//      'Comment',
//      comment.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.ignore,
//    );
//  }
//
//  Future<List<BookDB>> _readBooks() async {
//    final db = await database;
//    final List<Map<String, dynamic>> _books = await db.query('Book');
//    print(_books);
//    return _books.map((_book) => BookDB.fromMap(_book)).toList();
//  }
//
//  Future<List<CommentDB>> _readAllComments(String bookId) async {
//    final db = await database;
//    final List<Map<String, dynamic>> _comments =
//        await db.query('Comment', where: 'book_id = ?', whereArgs: [bookId]);
//    return _comments.map((_comment) => CommentDB.fromMap(_comment)).toList();
//  }
//
//  Future<UserDB> _readUser(String userId) async {
//    final db = await database;
//    final response =
//        await db.query('User', where: 'id = ?', whereArgs: [userId]);
//    final UserDB userDB = UserDB.fromMap(response[0]);
//  }
//
//  Future<Comment> _readComments(String bookId) async {
//    final db = await database;
//    final commentMap = Map<String, dynamic>();
//    final commentsMap =
//        await db.query('Comments', where: 'book_id = ?', whereArgs: [bookId]);
//    final comments =
//        commentsMap.map((commentMap) => CommentDB.fromMap(commentMap));
//  }
//
//  Future<List<Book>> retrieveAllBooks() async {
//    final db = await database;
//    final sql = """
//    select * from Book
//      join Genre on Genre.book_id = Book.id
//
//    """;
//    print(await db.rawQuery(sql));
//  }
//
//  Future insertBook(Book book) async {
//    await _insertBook(BookDB(
//      id: book.id,
//      pages: book.pages,
//      isBestSeller: book.isBestSeller,
//      coverImage: book.coverImage,
//      author: book.author,
//      title: book.title,
//      price: book.price,
//      description: book.description,
//      rating: book.rating,
//    ));
//    book.genre.forEach((_genre) async {
//      await _insertGenre(
//        GenreDB(
//          bookId: book.id,
//          genre: _genre,
//        ),
//      );
//    });
//
//    book.comments.forEach((comment) async {
//      await _insertUser(UserDB(
//        id: comment.postedBy.id,
//        name: comment.postedBy.username,
//      ));
//      await _insertComment(CommentDB(
//        id: comment.id,
//        bookId: book.id,
//        userId: comment.postedBy.id,
//        comment: comment.comment,
//      ));
//    });
//  }
//
////  Future<List<BookDB>> books() async {
////    final db = await database;
////    final List<Map<String, dynamic>> books = await db.query('Book');
////    return books.map((book) => BookDB.fromMap(book)).toList();
////  }
//
////  Future genre(String bookId) async {
////    final db = await database;
////
////    final List<Map<String, dynamic>> _genres = await db.query(
////      'Genre',
////      where: 'book_id = ?',
////      whereArgs: [bookId],
////    );
////    final genres =
////        _genres.map((_genre) => GenreDB.fromMap(_genre).genre).toList();
////    return genres;
////  }
//
//}
