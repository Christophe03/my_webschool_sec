import 'package:flutter/material.dart';

class CircleAvatarWithText extends StatelessWidget {
  final String text;
  final double radius;
  final Color backgroundColor;
  final Color textColor;

  const CircleAvatarWithText({
    Key? key,
    required this.text,
    required this.radius,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: radius * 0.5, // Adjust the font size as per your need
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
