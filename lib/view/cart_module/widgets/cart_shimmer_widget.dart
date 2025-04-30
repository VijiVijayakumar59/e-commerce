import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmerWidget extends StatelessWidget {
  const CartShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(24),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: size.height * 0.11,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white, // Important for shimmer
          ),
          child: Row(
            children: [
              Container(width: size.width * 0.23, height: size.height * 0.08, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10))),
              SizedBox(width: size.width * 0.01),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, width: size.width * 0.4, color: Colors.white),
                      SizedBox(height: size.height * 0.005),
                      const Spacer(),
                      Row(
                        children: [
                          Container(height: 16, width: size.width * 0.2, color: Colors.white),
                          const Spacer(),
                          Container(
                            height: size.height * 0.028,
                            width: size.width * 0.18,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
