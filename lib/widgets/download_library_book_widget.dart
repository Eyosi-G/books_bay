import 'dart:io';

import 'package:books_bay/blocs/library/library_bloc.dart';
import 'package:books_bay/blocs/library/library_event.dart';
import 'package:books_bay/blocs/library_item/library_item_bloc.dart';
import 'package:books_bay/blocs/library_item/library_item_event.dart';
import 'package:books_bay/blocs/library_item/library_item_state.dart';
import 'package:books_bay/models/db_models/db_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants.dart';
import 'library_book_widget.dart';

class DownloadLibraryBookWidget extends StatefulWidget {
  final Download download;
  DownloadLibraryBookWidget(this.download);

  @override
  _DownloadLibraryBookWidgetState createState() =>
      _DownloadLibraryBookWidgetState();
}

class _DownloadLibraryBookWidgetState extends State<DownloadLibraryBookWidget> {
  LibraryItemBloc _libraryItemBloc;
  @override
  void didChangeDependencies() {
    _libraryItemBloc = LibraryItemBloc();
    _libraryItemBloc.add(CheckDownloadStatus(widget.download));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _libraryItemBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              '${Endpoints.imageURL(widget.download.coverImageName)}',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black54,
            ),
          ),
          BlocConsumer<LibraryItemBloc, LibraryItemState>(
            cubit: _libraryItemBloc,
            listener: (ctx, state) {
              if (state is DownloadErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.message}'),
                  ),
                );
              }
            },
            builder: (ctx, state) {
              if (state is AlreadyDownloadedState) {
                return LibraryBookWidget(widget.download);
              }
              if (state is DownloadSucceededState) {
                return LibraryBookWidget(widget.download);
              }

              if (state is LoadingLibraryItemState) {
                return Positioned.fill(
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: 50,
                      percent: state.percent,
                      progressColor: Theme.of(context).primaryColor,
                      center: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.cloud_download_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _libraryItemBloc.add(
                          StartDownload(widget.download),
                        );
                      },
                    ),
                    Text(
                      'download',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
