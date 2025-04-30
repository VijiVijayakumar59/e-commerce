part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;
  ProductLoaded({required this.product});
}

final class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}
