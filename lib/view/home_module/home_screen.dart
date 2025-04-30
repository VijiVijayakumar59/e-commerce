import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopify/core/helper.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/providers/product_bloc/product_bloc.dart';
import 'package:shopify/providers/wishlist_bloc/wishlist_bloc.dart';
import 'package:shopify/view/cart_module/cart_screen.dart';
import 'package:shopify/view/home_module/widgets/home_shimmer_widget.dart';
import 'package:shopify/view/home_module/widgets/product_grid_widget.dart';
import 'package:shopify/view/wishlist_module.dart/wishlist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    BlocProvider.of<CartItemBloc>(context).add(GetCartItems());
    BlocProvider.of<WishlistBloc>(context).add(GetWishlistItem());
    BlocProvider.of<ProductBloc>(context).add(GetProducts());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.settings_suggest, size: 40),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, PageTransition(duration: Duration(milliseconds: 800), type: PageTransitionType.leftToRight, child: CartScreen()));
                          },
                          child: BlocBuilder<CartItemBloc, CartItemState>(
                            builder: (context, state) {
                              if (state is CartSuccess) {
                                return badges.Badge(
                                  showBadge: state.cartItems.isEmpty ? false : true,
                                  badgeContent: Text(state.cartItems.length.toString(), style: TextStyle(color: Colors.white, fontSize: 10)),
                                  position: badges.BadgePosition.topEnd(top: -4, end: -4),
                                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red, padding: EdgeInsets.all(5), shape: badges.BadgeShape.circle),
                                  child: Icon(Icons.shopping_cart_outlined, size: 26),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                        SizedBox(width: size.width * 0.04),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, PageTransition(duration: Duration(milliseconds: 800), type: PageTransitionType.leftToRight, child: WishlistScreen()));
                          },
                          child: BlocBuilder<WishlistBloc, WishlistState>(
                            builder: (context, state) {
                              if (state is WishlistSuccess) {
                                return badges.Badge(
                                  showBadge: state.data.isEmpty ? false : true,
                                  badgeContent: Text(state.data.length.toString(), style: TextStyle(color: Colors.white, fontSize: 10)),
                                  position: badges.BadgePosition.topEnd(top: -4, end: -4),
                                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red, padding: EdgeInsets.all(5), shape: badges.BadgeShape.circle),
                                  child: Icon(CupertinoIcons.heart, size: 26),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Text(welcome, style: GoogleFonts.prompt(textStyle: const TextStyle(letterSpacing: .5, fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(height: size.height * 0.008),
                Text(
                  ourFashionStore,
                  style: GoogleFonts.prompt(textStyle: const TextStyle(letterSpacing: .5, fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: size.height * 0.016),
                Text(topProducts, style: GoogleFonts.prompt(textStyle: const TextStyle(letterSpacing: .5, fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(height: size.height * 0.012),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return HomeShimmerWiget();
                    } else if (state is ProductLoaded) {
                      return ProductGridWidget(products: state.product);
                    } else if (state is ProductError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [SizedBox(height: 5), Text(state.error, style: TextStyle(fontSize: 20), textAlign: TextAlign.center), SizedBox(height: 5)],
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
