import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum webviewState { finished }

class WebViewScreen extends StatefulWidget {
  final String url;
  WebViewScreen(this.url);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _streamController = StreamController<webviewState>();
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (val) {
                _streamController.sink.add(webviewState.finished);
              },
            ),
          ),
          Positioned.fill(
            child: StreamBuilder<webviewState>(
              stream: _streamController.stream,
              builder: (ctx, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data == webviewState.finished) {
                  return Container();
                }
                return Container(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
