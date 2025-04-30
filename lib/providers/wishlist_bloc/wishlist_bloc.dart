import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopify/models/wishlist_model.dart';
import 'package:shopify/services/wishlist_service.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<GetWishlistItem>(_getWishlistItems);
    on<AddToWishlist>(_addToCart);
    on<RemoveFromWishlist>(_removeFromWishlist);
    on<IsWishlisted>(_isWishlisted);
  }
}

void _getWishlistItems(GetWishlistItem event, Emitter<WishlistState> emit) async {
  try {
    emit(WishlistLoading());
    final List<WishlistItemModel> wishlistItems = await WishlistDatabase.instance.fetchWishlistItems();
    emit(WishlistSuccess(data: wishlistItems));
  } catch (e) {
    emit(WishlistError(errorMessage: e.toString()));
  }
}

void _addToCart(AddToWishlist event, Emitter<WishlistState> emit) async {
  try {
    emit(WishlistLoading());
    await WishlistDatabase.instance
        .addToWishlist(event.item)
        .then((value) async {
          final List<WishlistItemModel> wishlistItems = await WishlistDatabase.instance.fetchWishlistItems();
          emit(WishlistSuccess(data: wishlistItems));
        })
        .onError((error, stackTrace) {
          emit(WishlistError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(WishlistError(errorMessage: e.toString()));
  }
}

void _removeFromWishlist(RemoveFromWishlist event, Emitter<WishlistState> emit) async {
  try {
    emit(WishlistLoading());
    await WishlistDatabase.instance
        .removeFromWishlist(event.id)
        .then((value) async {
          final List<WishlistItemModel> wishlistItems = await WishlistDatabase.instance.fetchWishlistItems();
          emit(WishlistSuccess(data: wishlistItems));
        })
        .onError((error, stackTrace) {
          emit(WishlistError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(WishlistError(errorMessage: e.toString()));
  }
}

void _isWishlisted(IsWishlisted event, Emitter<WishlistState> emit) async {
  try {
    emit(WishlistLoading());
    await WishlistDatabase.instance
        .isItemInWishlist(event.id)
        .then((value) async {
          await WishlistDatabase.instance.removeFromWishlist(event.id);
          final List<WishlistItemModel> wishlistItems = await WishlistDatabase.instance.fetchWishlistItems();
          emit(WishlistSuccess(data: wishlistItems));
        })
        .onError((error, stackTrace) {
          emit(WishlistError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(WishlistError(errorMessage: e.toString()));
  }
}
