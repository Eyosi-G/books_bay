import 'package:books_bay/models/db_models/db_models.dart';

abstract class LibraryItemEvent {}

class CheckDownloadStatus extends LibraryItemEvent {
  final Download download;
  CheckDownloadStatus(this.download);
}

class StartDownload extends LibraryItemEvent {
  final Download download;
  StartDownload(this.download);
}

class DownloadFinished extends LibraryItemEvent {}

class DownloadingEvent extends LibraryItemEvent {
  final double percent;
  DownloadingEvent(this.percent);
}

class DownloadFailed extends LibraryItemEvent {
  final String message;
  DownloadFailed(this.message);
}
