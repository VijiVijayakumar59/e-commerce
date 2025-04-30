import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWiget extends StatelessWidget {
  const HomeShimmerWiget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight), crossAxisSpacing: 10.0, mainAxisSpacing: 16.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: size.width * 0.180, height: size.height * 0.180, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25))),
                SizedBox(height: size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: size.width * 0.1, height: size.height * 0.012, color: Colors.white),
                      SizedBox(height: size.height * 0.005),
                      Container(width: size.width * 0.08, height: size.height * 0.01, color: Colors.white),
                      SizedBox(height: size.height * 0.008),
                      Container(width: size.width * 0.04, height: size.height * 0.012, color: Colors.white),
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
