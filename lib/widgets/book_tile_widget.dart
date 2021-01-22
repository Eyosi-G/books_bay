import 'package:flutter/material.dart';

class BookTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 90;
    final double width = 70;
    return Container(
      height: height,
      child: Row(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.red,
            child: Image.network(
              'https://ebooks-bay.herokuapp.com/api/v1/images/_Cover_Tools_of_Titans.jpg',
              fit: BoxFit.contain,
              height: height,
              width: width,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4.0',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Text(
                      '20 ETB',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
