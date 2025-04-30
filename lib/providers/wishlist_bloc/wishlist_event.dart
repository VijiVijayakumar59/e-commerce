part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class GetWishlistItem extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final WishlistItemModel item;
  AddToWishlist({required this.item});
}

class RemoveFromWishlist extends WishlistEvent {
  final int id;
  RemoveFromWishlist({required this.id});
}

class IsWishlisted extends WishlistEvent {
  final int id;
  IsWishlisted({required this.id});
}
