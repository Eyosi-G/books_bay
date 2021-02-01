import 'package:books_bay/models/book.dart';
import 'package:books_bay/widgets/book_tile_widget.dart';
import 'package:books_bay/widgets/checkout_widget.dart';
import 'package:books_bay/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final titleStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );
//  final valueStyle = TextStyle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: customAppBar(context, 'Order Detail'),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: titleStyle,
                        ),
                        Text('Pending')
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Row(
                      children: [
                        Text(
                          'Order Date: ',
                          style: titleStyle,
                        ),
                        Text('Dec 12, 2020')
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookTileWidget(Book()),
                          ),
                        );
                      },
                      itemCount: 5,
                      separatorBuilder: (ctx, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            minWidth: double.infinity,
            color: Theme.of(context).buttonColor,
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    content: Container(),
                  );
                },
              );
            },
            child: Text(
              'CHECHOUT',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
