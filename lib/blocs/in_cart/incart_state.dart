abstract class InCartState {}

class InitialInCartState extends InCartState {}

class InCartStateChanged extends InCartState {
  final bool isInCart;
  InCartStateChanged(this.isInCart);
}
