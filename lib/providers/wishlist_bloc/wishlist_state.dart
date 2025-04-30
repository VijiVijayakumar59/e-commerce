part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final List<WishlistItemModel> data;
  WishlistSuccess({required this.data});
}

class WishlistError extends WishlistState {
  final String errorMessage;
  WishlistError({required this.errorMessage});
}
