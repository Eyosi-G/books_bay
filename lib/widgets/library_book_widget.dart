import 'package:flutter/material.dart';

class LibraryBookWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        title: Text(
          'In the Woods',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.black38,
        subtitle: Text(
          'Tana French',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: Colors.white,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      child: Image.network(
        'https://ebooks-bay.herokuapp.com/api/v1/images/_Cover_Tools_of_Titans.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
