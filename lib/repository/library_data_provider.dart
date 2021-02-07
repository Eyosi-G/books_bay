import 'dart:convert';

import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/models/book.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import 'auth_data_provider.dart';

class LibraryDataProvider {
  Future<List<Book>> fetchBooks(String id, String token) async {
    final client = Client();
    final response =
        await client.get(Endpoints.getPurchasedBooksURL(id), headers: {
      'content-type': 'application/json',
      'authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception("response failed");
    }
    final _books = json.decode(response.body) as List;
    return _books.map((_book) => Book.fromJson(_book)).toList();
  }

  fetchAndSave() async {
    //todo: token
    try {
      final auth = await AuthDataProvider.getAuth();
      final provider = DatabaseProvider();
      final books = await fetchBooks(auth.id, auth.token);
      final downloads = books.map((book) {
        downloadImage(book.coverImage);
        return Download(
          bookName: book.bookName,
          author: book.author,
          title: book.title,
          id: book.id,
          coverImageName: book.coverImage,
        );
      }).toList();
      await provider.insertAll(downloads);
    } catch (e) {
      print(e);
    }
  }

  Future downloadImage(String image) async {
    final client = Dio();
    final tempDir = await getTemporaryDirectory();

    final response = await client.download(
        Endpoints.imageURL(image), '${tempDir.path}/$image');
    if (response.statusCode != 200) {
      throw Exception("response failed");
    }
  }

//  Future downloadBook(
//      {@required String id, @required Function onReceiveProgress}) async {
//    final auth = await AuthDataProvider.getAuth();
//    final String token = auth.token;
//    final client = Dio();
//    final response = await client.get(
//      Endpoints.downloadURL(id),
//      onReceiveProgress: onReceiveProgress,
//      options: Options(
//          responseType: ResponseType.bytes,
//          followRedirects: false,
//          validateStatus: (status) {
//            return status < 500;
//          },
//          headers: {
//            'authorization': 'Bearer $token',
//          }),
//    );
//    return response.data;
//  }
}
