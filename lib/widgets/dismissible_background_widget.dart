import 'package:flutter/material.dart';

class DismissibleBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Icon(
          Icons.delete_outline,
          size: 30,
        ),
      ),
    );
  }
}
