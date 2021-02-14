import 'dart:convert';

import 'package:books_bay/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LibraryDataProvider {
  Future<List<Book>> fetchMyBooks(
      {@required String userId, @required String token}) async {
    final client = http.Client();
    final response = await client.get(
      Endpoints.getUsersBooks(userId),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('creating book failed');
    }
    final jsonBooks = json.decode(response.body) as List;
    return jsonBooks.map((jsonBook) => Book.fromJson(jsonBook)).toList();
  }

  deleteBook({@required String bookId, @required String token}) async {
    final client = http.Client();
    final response = await client.delete(
      Endpoints.deleteBookURL(bookId),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('deleting book failed');
    }
  }

  updateBook({
    @required String token,
    @required Book book,
    @required bool isFileSelected,
  }) async {
    File imageFile;
    if (!isFileSelected) imageFile = await _fileFromImageUrl(book.coverImage);
    print(imageFile);
    final client =
        http.MultipartRequest("PUT", Uri.parse(Endpoints.updateBookURL))
          ..fields['title'] = book.title
          ..fields['author'] = book.author
          ..fields['description'] = book.description
          ..fields['isBestSeller'] = '${book.isBestSeller}'
          ..fields['bookId'] = book.id
          ..files.add(
            await http.MultipartFile.fromPath(
                "image", isFileSelected ? book.coverImage : imageFile.path),
          );

    client.headers.addAll({
      "authorization": "Bearer $token",
    });
    final response = await client.send();
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('editing book failed');
    }
    final data = json.decode(await response.stream.bytesToString());
    return Book.fromJson(data);
  }

  Future<Book> createBook({
    @required String token,
    @required Book book,
  }) async {
    final client = http.MultipartRequest(
        "POST", Uri.parse(Endpoints.insertBookURL))
      ..fields['title'] = book.title
      ..fields['author'] = book.author
      ..fields['description'] = book.description
      ..fields['isBestSeller'] = '${book.isBestSeller}'
      ..files.add(await http.MultipartFile.fromPath("image", book.coverImage));

    client.headers.addAll({"authorization": "Bearer $token"});
    final response = await client.send();
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('creating book failed');
    }
    final data = json.decode(await response.stream.bytesToString());
    return Book.fromJson(data);
  }

  Future<File> _fileFromImageUrl(String image) async {
    final response = await http.get(Endpoints.imageURL(image));
    final tempDir = await getTemporaryDirectory();
    final file = File(join(tempDir.path, image));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
