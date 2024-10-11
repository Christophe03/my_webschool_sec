import 'package:flutter/material.dart';

import '../utils/constants_util.dart';

class AppName extends StatelessWidget {
  final double fontSize;
  final String school;
  const AppName({Key? key, required this.fontSize, required this.school})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: school,
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
