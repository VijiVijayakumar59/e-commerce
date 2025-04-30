import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/view/home_module/widgets/image_shimmer_widget.dart';
import 'package:shopify/view/product_detail_module/product_detail_screen.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final crossAxisCount = orientation == Orientation.portrait ? 2 : 3;
    final double itemHeight = orientation == Orientation.portrait ? (size.height - kToolbarHeight - 24) / 2.5 : (size.height - kToolbarHeight - 24) / 1.7;
    final double itemWidth = size.width / crossAxisCount;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: itemWidth / itemHeight,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(duration: Duration(milliseconds: 800), type: PageTransitionType.leftToRight, child: ProductDetailScreen(products: product)),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.185,
                  child: Image(
                    image: Image.network(product.image).image,
                    fit: BoxFit.contain,
                    loadingBuilder:
                        (context, child, loadingProgress) => loadingProgress == null ? child : ImageShimmer(imgHeight: size.height * 0.180, imgWidth: size.width * 0.180),
                  ),
                ),

                SizedBox(height: size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(letterSpacing: .5, fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.description,
                        style: TextStyle(letterSpacing: .5, fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.008),
                      Text("\$${product.price.toStringAsFixed(2)}", style: TextStyle(letterSpacing: .5, fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
