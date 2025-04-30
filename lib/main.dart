import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/providers/product_bloc/product_bloc.dart';
import 'package:shopify/providers/wishlist_bloc/wishlist_bloc.dart';
import 'package:shopify/view/home_module/home_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ProductBloc()), BlocProvider(create: (context) => CartItemBloc()), BlocProvider(create: (context) => WishlistBloc(),)],
      child: MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: const HomeScreen()),
    );
  }
}
