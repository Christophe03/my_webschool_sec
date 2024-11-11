import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class CircularBouton extends StatelessWidget {
  final double? size;
  final IconData? icon;
  final void Function() onTap;
  const CircularBouton(
      {super.key, required this.size, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kColorSecondaryLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorPrimary,
              ),
              child: Icon(
                icon!,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
