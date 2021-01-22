import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Bag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  BookTileWidget(),
                  SizedBox(
                    height: 5,
                  ),
                  BookTileWidget(),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            FlatButton(
              minWidth: double.infinity,
              color: Colors.green,
              onPressed: () {},
              child: Text(
                'Checkout',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.white),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
          ],
        ),
      ),
    );
  }
}
