import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class PageTitle extends StatelessWidget {
  final double fontSize;
  final String title;
  const PageTitle({super.key, required this.fontSize, required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: kColorLight),
        children: <TextSpan>[],
      ),
    );
  }
}
