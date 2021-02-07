import 'dart:async';

import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'package:books_bay/repository/auth_data_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';

class DownloadService {
  final _controller = StreamController();
  Stream get downloadStream => _controller.stream;

  dispose() {
    _controller.close();
  }

  downloadBook({@required Download download}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final auth = await AuthDataProvider.getAuth();
      final String token = auth.token;
      final client = Dio();
      client.download(
        Endpoints.downloadURL(download.id),
        '${tempDir.path}/${download.id}.pdf',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }),
        onReceiveProgress: (int received, int total) {
          if (total != -1) {
            _controller.sink.add((received / total * 100));
          } else {
            _controller.sink.addError(Error());
          }
        },
      ).then((value) async {
        await DatabaseProvider().update(download);
      }, onError: (error) {
        _controller.addError(error);
      });
    } catch (e) {
      _controller.addError(e);
    }
  }
}

//onReceiveProgress: onReceiveProgress,
//options: Options(
//responseType: ResponseType.bytes,
//followRedirects: false,
//validateStatus: (status) {
//return status < 500;
//},
//headers: {
//'authorization': 'Bearer $token',
//}),
