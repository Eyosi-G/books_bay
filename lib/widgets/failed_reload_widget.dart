import 'package:flutter/material.dart';

class FailedReloadWidget extends StatelessWidget {
  final Function reload;
  final String message;
  FailedReloadWidget(this.message, this.reload);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/loading_failed.png',
            width: 70,
            height: 70,
          ),
        ),
        Center(
          child: Text('$message'),
        ),
        SizedBox(height: 10),
        OutlineButton(
          onPressed: reload,
          child: Text('Reload'),
        ),
      ],
    );
  }
}
