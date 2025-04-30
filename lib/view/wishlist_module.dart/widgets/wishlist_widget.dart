import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/models/cart_item_model.dart';
import 'package:shopify/models/wishlist_model.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/providers/wishlist_bloc/wishlist_bloc.dart';

class WishlistWidget extends StatelessWidget {
  final WishlistItemModel data;
  const WishlistWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: isPortrait ? size.height * 0.17 : size.height * 0.3,
        width: double.infinity,
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: isPortrait ? size.width * 0.15 : size.width * 0.15,
                            height: isPortrait ? size.height * 0.07 : size.height * 0.1,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(data.image), fit: BoxFit.contain)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: Text(
                                  data.title,
                                  style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: size.height * 0.008),
                              SizedBox(
                                width: size.width * 0.55,
                                child: Text(
                                  data.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<WishlistBloc>(context).add(RemoveFromWishlist(id: data.id));
                    },
                    child: const Icon(CupertinoIcons.heart_slash_fill, color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.008),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${data.price}',
                    style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final cartItem = CartItemModel(id: data.id, title: data.title, price: data.price, image: data.image);
                      BlocProvider.of<CartItemBloc>(context).add(AddToCart(cartItem: cartItem));
                    },
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.cart),
                        Text(
                          '  Add to cart',
                          style: GoogleFonts.poppins(textStyle: const TextStyle(letterSpacing: .5, fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
