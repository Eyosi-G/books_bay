import 'package:books_bay/blocs/cart_list/cart_list_bloc.dart';
import 'package:books_bay/blocs/checkout/checkout_bloc.dart';
import 'package:books_bay/blocs/checkout/checkout_event.dart';
import 'package:books_bay/blocs/checkout/checkout_state.dart';
import 'package:books_bay/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutWidget extends StatefulWidget {
  final CartListBloc cartListBloc;
  CheckoutWidget(this.cartListBloc);
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  CheckoutBloc _checkoutBloc;
  @override
  void initState() {
    _checkoutBloc = CheckoutBloc(widget.cartListBloc);
    super.initState();
  }

  @override
  void dispose() {
    _checkoutBloc.close();
    super.dispose();
  }

  _payNowHandler() {
    if (_checkoutBloc.state is CheckoutCompletedState) {
      final checkout = (_checkoutBloc.state as CheckoutCompletedState).checkout;
      _checkoutBloc.add(PayNow(checkout));
//      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w600,
    );
    return Container(
      padding: EdgeInsets.all(10),
      height: 215,
      child: BlocConsumer<CheckoutBloc, CheckoutState>(
        cubit: _checkoutBloc,
        listener: (ctx, state) async {
//          print('here');
//          if (state is CheckoutLoadingState) {
//            showDialog(
//              context: context,
//              builder: (ctx) => SimpleDialog(
//                children: [
//                  Center(
//                    child: CircularProgressIndicator(),
//                  ),
//                ],
//              ),
//            );
//          }
          if (state is CheckoutLinkGenerated) {
            final checkoutLink = state.checkoutLink;
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => WebViewScreen(checkoutLink)),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (ctx, state) {
          if (state is InitialCheckoutState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutCompletedState) {
            final checkout = state.checkout;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Amount',
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ),
                    ),
                    Text(
                      '${checkout.amount} books',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: titleStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${checkout.totalPrice} ETB',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Container(
                  child: Image.asset(
                    'assets/images/yenepay.jpg',
                    height: 100,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _payNowHandler();
                  },
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'PAY NOW',
                    style: titleStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }
          if (state is GeneratingLinkState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Generating payement link'),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
