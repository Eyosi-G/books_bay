import 'package:books_bay/widgets/custom_app_bar.dart';
import 'package:books_bay/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Order Histories'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return Container(
                    child: OrderListTile(index),
                    color: Color(0xfff7f7e8),
                  );
                },
                itemCount: 5,
                separatorBuilder: (ctx, index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
