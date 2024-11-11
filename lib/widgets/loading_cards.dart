import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../utils/constants_util.dart';

class LoadingFeaturedCard extends StatelessWidget {
  const LoadingFeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
            margin: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kColorPrimary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5))));
  }
}

class LoadingCard extends StatelessWidget {
  final double? height;
  const LoadingCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: kColorSecondaryLight,
              borderRadius: BorderRadius.circular(5)),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
