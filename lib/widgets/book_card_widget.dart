import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  final double height;
  BookCardWidget({this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: Image.network(
              'https://ebooks-bay.herokuapp.com/api/v1/images/_Cover_Tools_of_Titans.jpg',
              fit: BoxFit.cover,
              height: height,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'In the Woods',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Tana French',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
