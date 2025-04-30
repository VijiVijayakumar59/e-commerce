part of 'cart_item_bloc.dart';

@immutable
sealed class CartItemState {}

final class CartItemInitial extends CartItemState {}

class CartLoading extends CartItemState {}

class CartSuccess extends CartItemState {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  CartSuccess({required this.cartItems, required this.totalPrice});
}

class CartError extends CartItemState {
  final String errorMessage;
  CartError({required this.errorMessage});
}
