import 'package:flutter/material.dart';

class ScratchScreen extends StatefulWidget {
//  loadBook(BuildContext context) {
//    const url =
//        'https://www.wmata.com/schedules/maps/upload/2019-System-Map.pdf';
//    Navigator.of(context).push(
//      MaterialPageRoute(
//        builder: (ctx) {
//          return WebViewScreen();
//        },
//      ),
//    );
//  }
  @override
  _ScratchScreenState createState() => _ScratchScreenState();
}

class _ScratchScreenState extends State<ScratchScreen> {
  _loadBook() async {
//    final dbProvider = DatabaseProvider();

//    print(await dbProvider.genre("book_1"));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: FlatButton(
              child: Text('open'),
              onPressed: () => _loadBook(),
            ),
          ),
        ),
      ),
    );
  }
}
