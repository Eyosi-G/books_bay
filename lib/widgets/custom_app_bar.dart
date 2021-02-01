import 'package:flutter/material.dart';

customAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    centerTitle: true,
    title: Text(
      '$title',
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 16,
          ),
    ),
  );
}
