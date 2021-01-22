import 'dart:ui';

import 'package:books_bay/widgets/category_chip.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_bag,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Card(
                        elevation: 5,
                        child: Image.network(
                          'https://ebooks-bay.herokuapp.com/api/v1/images/_Cover_Tools_of_Titans.jpg',
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Tools of Titans',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Tim Ferriss',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tools of Titans is a bible of the best advice Tim Ferriss has learned while running his podcast. Tim has interviewed over two hundred successful individuals on his podcast, The Tim Ferriss Show. These guests range from super celebrities, such as Jamie Foxx, Arnold Schwarzenegger and Seth Rogen, to extreme athletes and black-market biochemists. However, what each of these individuals shares is a recipe for success. This book contains an integration of all the insightful tools, tactics, tips, and tricks offered by these podcast guests.',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  children: [
                    CategoryChip(
                      category: 'Childrens',
                    ),
                    CategoryChip(
                      category: 'Mystery',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '120 ETB',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    FlatButton.icon(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      label: Text('Add To Bag'),
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textColor: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
