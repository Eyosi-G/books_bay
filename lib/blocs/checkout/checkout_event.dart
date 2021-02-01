import 'package:books_bay/models/checkout.dart';

abstract class CheckoutEvent {}

class CheckoutLoaded extends CheckoutEvent {}

class PayNow extends CheckoutEvent {
  final Checkout checkout;
  PayNow(this.checkout);
}
