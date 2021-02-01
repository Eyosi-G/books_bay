import '../../models/checkout.dart';

abstract class CheckoutState {}

class InitialCheckoutState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutCompletedState extends CheckoutState {
  final Checkout checkout;
  CheckoutCompletedState(this.checkout);
}

class CheckoutLinkGenerated extends CheckoutState {
  final String checkoutLink;
  CheckoutLinkGenerated(this.checkoutLink);
}

class CheckoutErrorState extends CheckoutState {
  final String message;
  CheckoutErrorState(this.message);
}
