import 'package:books_bay/widgets/book_card_widget.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:books_bay/widgets/category_lists_widget.dart';
import 'package:flutter/material.dart';

import 'book_detail_screen.dart';
import 'cart_screen.dart';

enum Selected { orders, logout }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return CartScreen();
                    },
                  ),
                );
              },
            ),
            PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'Orders',
                    ),
                    value: Selected.orders,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Logout',
                    ),
                    value: Selected.logout,
                  )
                ];
              },
              onSelected: (Selected selected) {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best Sellers',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BookCardWidget(
                        height: height * 0.28,
                      ),
                      BookCardWidget(
                        height: height * 0.28,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return BookDetailScreen();
                          }));
                        },
                        child: BookTileWidget(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      BookTileWidget(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
