import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/core/helper.dart';
import 'package:shopify/providers/wishlist_bloc/wishlist_bloc.dart';
import 'package:shopify/core/common/header_widget.dart';
import 'package:shopify/view/wishlist_module.dart/widgets/wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    BlocProvider.of<WishlistBloc>(context).add(GetWishlistItem());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(headName: myWishlist),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  if (state is WishlistLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WishlistError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [SizedBox(height: 5), Text(state.errorMessage, style: TextStyle(fontSize: 20), textAlign: TextAlign.center), SizedBox(height: 5)],
                      ),
                    );
                  } else if (state is WishlistSuccess) {
                    if (state.data.isEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: SizedBox(height: size.height < 412 ? size.height * 0.4 : size.height * 0.5, child: Lottie.asset(emptyLottiePath))),
                          Text(wishlistIsEmpty, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: size.height < 412 ? 18 : 26)),
                        ],
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(height: size.height * 0.02),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return WishlistWidget(data: state.data[index]);
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
