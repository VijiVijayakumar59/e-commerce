import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProducts>(productList);
  }
}

void productList(GetProducts event, Emitter<ProductState> emit) async {
  try {
    emit(ProductLoading());
    final List<Product> data = await ProductServices().fetchProducts();
    log(data.toString());
    emit(ProductLoaded(product: data));
  } catch (e) {
    emit(ProductError(e.toString()));
  }
}
