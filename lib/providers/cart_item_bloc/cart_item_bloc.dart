import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopify/models/cart_item_model.dart';
import 'package:shopify/services/cart_service.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  CartItemBloc() : super(CartItemInitial()) {
    on<GetCartItems>(_getCartItems);
    on<AddToCart>(_addToCart);
    on<RemoveCartItem>(_removeCartItem);
    on<UpdateItemQuantity>(_updateItemQuantity);
  }
}

void _getCartItems(GetCartItems event, Emitter<CartItemState> emit) async {
  try {
    emit(CartLoading());
    final List<CartItemModel> cartItems = await CartDatabase.instance.fetchCartItems();
    final double totalPrice = await CartDatabase.instance.getTotalCartPrice();
    emit(CartSuccess(cartItems: cartItems, totalPrice: totalPrice));
  } catch (e) {
    emit(CartError(errorMessage: e.toString()));
  }
}

void _addToCart(AddToCart event, Emitter<CartItemState> emit) async {
  try {
    emit(CartLoading());
    await CartDatabase.instance
        .insertCartItem(event.cartItem)
        .then((value) async {
          final List<CartItemModel> cartItems = await CartDatabase.instance.fetchCartItems();
          final double totalPrice = await CartDatabase.instance.getTotalCartPrice();
          emit(CartSuccess(cartItems: cartItems, totalPrice: totalPrice));
        })
        .onError((error, stackTrace) {
          emit(CartError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(CartError(errorMessage: e.toString()));
  }
}

void _removeCartItem(RemoveCartItem event, Emitter<CartItemState> emit) async {
  try {
    emit(CartLoading());
    await CartDatabase.instance
        .deleteCartItem(event.id)
        .then((value) async {
          final List<CartItemModel> cartItems = await CartDatabase.instance.fetchCartItems();
          final double totalPrice = await CartDatabase.instance.getTotalCartPrice();
          emit(CartSuccess(cartItems: cartItems, totalPrice: totalPrice));
        })
        .onError((error, stackTrace) {
          emit(CartError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(CartError(errorMessage: e.toString()));
  }
}

void _updateItemQuantity(UpdateItemQuantity event, Emitter<CartItemState> emit) async {
  try {
    emit(CartLoading());
    await CartDatabase.instance
        .updateQuantity(event.id, event.quantity)
        .then((value) async {
          final List<CartItemModel> cartItems = await CartDatabase.instance.fetchCartItems();
          final double totalPrice = await CartDatabase.instance.getTotalCartPrice();
          emit(CartSuccess(cartItems: cartItems, totalPrice: totalPrice));
        })
        .onError((error, stackTrace) {
          emit(CartError(errorMessage: error.toString()));
        });
  } catch (e) {
    emit(CartError(errorMessage: e.toString()));
  }
}
