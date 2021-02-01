import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  CategoryChip({@required this.category});
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
