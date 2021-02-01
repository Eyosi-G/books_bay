import 'package:books_bay/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';

class OrderListTile extends StatelessWidget {
  final int index;
  OrderListTile(this.index);
  @override
  Widget build(BuildContext context) {
    final double height = 60;
    final double width = 3;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return OrderDetailScreen();
            },
          ),
        );
      },
      child: Container(
        height: height,
        child: Row(
          children: [
            Container(
              width: width,
              color: (index % 2 == 0) ? Colors.amber : Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3 books',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status: Paid',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Dec 12, 2020',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
