import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/core/helper.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/view/cart_module/widgets/cart_shimmer_widget.dart';
import 'package:shopify/view/cart_module/widgets/slidable_widget.dart';
import 'package:shopify/core/common/header_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    BlocProvider.of<CartItemBloc>(context).add(GetCartItems());
    return SafeArea(
      child: Scaffold(
        body: BlocListener<CartItemBloc, CartItemState>(
          listener: (context, state) {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeaderWidget(headName: myCart),

                Expanded(
                  child: BlocBuilder<CartItemBloc, CartItemState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return CartShimmerWidget();
                      } else if (state is CartError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [SizedBox(height: 5), Text(state.errorMessage, style: TextStyle(fontSize: 20), textAlign: TextAlign.center), SizedBox(height: 5)],
                          ),
                        );
                      } else if (state is CartSuccess) {
                        if (state.cartItems.isEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: SizedBox(height: size.height < 412 ? size.height * 0.4 : size.height * 0.5, child: Lottie.asset(emptyLottiePath))),
                              Text(cartIsEmpty, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: size.height < 412 ? 18 : 26)),
                            ],
                          );
                        }
                        return ListView.separated(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            return SlidableWidget(data: state.cartItems[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: height * 0.03),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 10),
                  child: Column(
                    children: [
                      BlocBuilder<CartItemBloc, CartItemState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              Text(
                                state is CartSuccess ? 'Total ${state.cartItems.length} items' : 'Total :',
                                style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w900)),
                              ),
                              const Spacer(),
                              Text(
                                state is CartSuccess ? '\$ ${state.totalPrice.toStringAsFixed(2)}' : '0.00',

                                style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: height * 0.01),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              proceedToCheckout,
                              style: GoogleFonts.poppins(textStyle: const TextStyle(letterSpacing: .5, fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
                            ),
                            Icon(Icons.arrow_forward_sharp, size: 28),
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
