import 'package:flutter/material.dart';
import 'category_chip.dart';
import '../data/categories.dart';

class CategoryListsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: categories
          .map(
            (category) => CategoryChip(
              category: '$category',
            ),
          )
          .toList(),
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 3,
    );
  }
}
