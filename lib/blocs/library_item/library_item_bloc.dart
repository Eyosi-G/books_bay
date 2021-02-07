import 'dart:async';

import 'package:books_bay/db_provider/database_provider.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'package:books_bay/repository/library_data_provider.dart';
import 'package:books_bay/util/download_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'library_item_event.dart';
import 'library_item_state.dart';

class LibraryItemBloc extends Bloc<LibraryItemEvent, LibraryItemState> {
  DownloadService _downloadService;
  LibraryItemBloc() : super(InitialLibraryItemState()) {
    _downloadService = DownloadService();
    _downloadService.downloadStream.listen((event) {
      if (event == 100) {
        return add(DownloadFinished());
      }
      add(DownloadingEvent(event / 100));
    }).onError((error) {
      add(DownloadFailed('Downloading failed, please try again'));
    });
  }

  @override
  Stream<LibraryItemState> mapEventToState(LibraryItemEvent event) async* {
    try {
      if (event is CheckDownloadStatus) {
        final download = await DatabaseProvider().findById(event.download.id);
        if (download.isDownloaded) {
          yield AlreadyDownloadedState();
        }
      }
      if (event is StartDownload) {
        _downloadService.downloadBook(download: event.download);
      }
      if (event is DownloadFailed) {
        yield DownloadErrorState(event.message);
      }
      if (event is DownloadingEvent) {
        yield LoadingLibraryItemState(event.percent);
      }
      if (event is DownloadFinished) {
        yield DownloadSucceededState();
      }
    } catch (e) {
      yield DownloadErrorState(e.message);
    }
  }

  @override
  Future<void> close() {
    _downloadService.dispose();
    super.close();
  }
}
