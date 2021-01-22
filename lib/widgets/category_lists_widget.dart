import 'package:flutter/material.dart';
import 'category_chip.dart';
import '../data/categories.dart';

class CategoryListsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return CategoryChip(
          category: '${categories[index]}',
        );
      },
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
