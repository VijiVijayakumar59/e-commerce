part of 'cart_item_bloc.dart';

@immutable
sealed class CartItemEvent {}

class GetCartItems extends CartItemEvent {}

class AddToCart extends CartItemEvent {
  final CartItemModel cartItem;
  AddToCart({required this.cartItem});
}

class RemoveCartItem extends CartItemEvent {
  final int id;
  RemoveCartItem({required this.id});
}

class UpdateItemQuantity extends CartItemEvent {
  final int id;
  final int quantity;
  UpdateItemQuantity({required this.id, required this.quantity});
}

class GetTotalPrice extends CartItemEvent {}
