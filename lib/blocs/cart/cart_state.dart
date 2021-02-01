abstract class CartState {}

class InitialCartState extends CartState {}

class CartStateChanged extends CartState {
  final int cartCount;
  CartStateChanged(this.cartCount);
}
