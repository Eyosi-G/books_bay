abstract class LibraryItemState {}

class InitialLibraryItemState extends LibraryItemState {}

class AlreadyDownloadedState extends LibraryItemState {}

class LoadingLibraryItemState extends LibraryItemState {
  final double percent;
  LoadingLibraryItemState(this.percent);
}

class DownloadSucceededState extends LibraryItemState {}

class DownloadErrorState extends LibraryItemState {
  final String message;
  DownloadErrorState(this.message);
}
