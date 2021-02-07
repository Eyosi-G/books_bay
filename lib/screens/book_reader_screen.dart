import 'dart:async';
import 'dart:io';

import 'package:books_bay/models/db_models/db_models.dart';
import 'package:books_bay/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BookReaderScreen extends StatefulWidget {
  final Download download;
  BookReaderScreen(this.download);
  @override
  _BookReaderScreenState createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  String _document;
  int _page = 0;
  int _total;

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  _loadBook() async {
    final tempPath = await _tempPath;
    final file = File('$tempPath/${widget.download.id}.pdf');
    _document = file.path;
    setState(() {});
  }

  Future<String> get _tempPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  @override
  void initState() {
    _loadBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.download.title),
      floatingActionButton: FutureBuilder<PDFViewController>(
        builder: (ctx, snapshot) {
          if (snapshot.hasData && _total != null) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                '${_page + 1} / $_total',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }
          return Container();
        },
        future: _controller.future,
      ),
      body: _document == null
          ? Center(child: Text('Loading...'))
          : Stack(
              children: [
                PDFView(
                  filePath: _document,
                  fitPolicy: FitPolicy.BOTH,
                  defaultPage: _page,
                  pageSnap: false,
                  swipeHorizontal: true,
                  fitEachPage: false,
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (page, total) {
                    setState(() {
                      _total = total;
                      _page = page;
                    });
                  },
                ),
                Positioned(
                  child: FutureBuilder<PDFViewController>(
                    builder: (ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('loading ...'));
                      }
                      return Container();
                    },
                    future: _controller.future,
                  ),
                ),
              ],
            ),
    );
  }
}
