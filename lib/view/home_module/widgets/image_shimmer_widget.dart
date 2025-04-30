import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({required this.imgHeight, required this.imgWidth, super.key});
  final double imgHeight;
  final double imgWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgHeight,
      height: imgHeight,
      child: Shimmer.fromColors(baseColor: Color(0xFFF5F5F5), highlightColor: Color(0xFFE0E0E0), child: Container(color: Theme.of(context).colorScheme.primaryContainer)),
    );
  }
}
