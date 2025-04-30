import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/core/common/app_snackbar.dart';
import 'package:shopify/core/helper.dart';
import 'package:shopify/models/cart_item_model.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/models/wishlist_model.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/providers/wishlist_bloc/wishlist_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product products;

  const ProductDetailScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final height = orientation == Orientation.portrait ? (size.height - kToolbarHeight - 24) / 2.5 : (size.height - kToolbarHeight - 24) / 1.7;
    return SafeArea(
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<CartItemBloc, CartItemState>(
              listener: (context, state) {
                if (state is CartSuccess) {
                  AppSnackbar().showAwesomeSnackBar(context, success, itemAddedToCartSuccesfully, ContentType.success);
                } else if (state is CartError) {
                  AppSnackbar().showAwesomeSnackBar(context, error, itemAddingFailed, ContentType.failure);
                }
              },
            ),
          ],
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  height: height / 1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), image: DecorationImage(image: NetworkImage(products.image), fit: BoxFit.contain)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(radius: 18, backgroundColor: Colors.black, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0, right: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (context, state) {
                                bool isWishlisted = false;

                                if (state is WishlistSuccess) {
                                  isWishlisted = state.data.any((item) => item.id == products.id);
                                }

                                return IconButton(
                                  onPressed: () async {
                                    final data = WishlistItemModel(
                                      id: products.id,
                                      title: products.title,
                                      price: products.price,
                                      description: products.description,
                                      category: products.category,
                                      image: products.image,
                                    );

                                    if (isWishlisted) {
                                      BlocProvider.of<WishlistBloc>(context).add(RemoveFromWishlist(id: products.id));
                                      AppSnackbar().showAwesomeSnackBar(context, success, itemRemovedFromWishlist, ContentType.success);
                                    } else {
                                      BlocProvider.of<WishlistBloc>(context).add(AddToWishlist(item: data));
                                      AppSnackbar().showAwesomeSnackBar(context, success, itemAddedtoWishlist, ContentType.success);
                                    }
                                  },
                                  icon:
                                      isWishlisted
                                          ? Icon(CupertinoIcons.suit_heart_fill, color: Colors.red, size: 30)
                                          : Icon(CupertinoIcons.heart, size: 30, color: Colors.black),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        products.title,
                        style: GoogleFonts.prompt(textStyle: const TextStyle(letterSpacing: .5, fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                      Text(products.description, style: TextStyle(letterSpacing: .5, fontSize: 15, color: Colors.black54)),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Price'),
                          Text('\$ ${products.price.toString()}', style: GoogleFonts.prompt(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final data = CartItemModel(id: products.id, title: products.title, price: products.price, image: products.image);
                          BlocProvider.of<CartItemBloc>(context).add(AddToCart(cartItem: data));
                        },
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.cart),
                            Text(
                              'Add to cart',
                              style: GoogleFonts.poppins(textStyle: const TextStyle(letterSpacing: .5, fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
