import 'package:flutter/material.dart';

const hivedb = 'webschooldb';
const ktag = 'ktag';

const kColorPrimary = Color.fromRGBO(39, 135, 192, 1);
const kColorChat1 = Color(0xffffffff);
const kColorChat2 = Color(0xffeaf2fe);
const kColorPrimaryDark = Color(0xff1b3a5e);
const kColorSecondary = Color.fromARGB(255, 67, 230, 221);
const kColorSecondaryLight = Color(0xffEBF2F5);
const kColorDark = Color(0xff121212);
const kColorLight = Color(0xffEBF2F5);
const kColorBlue = Color.fromARGB(255, 90, 150, 248);
const kColorMaron = Color(0xffa33902);
const kColorDarkBlue = Color(0xff1b3a5e);
const kColorPink = Color(0xffe91e63);
const kColorAmber = Color.fromARGB(222, 247, 243, 31);
const kColorLihtGreen = Color(0xff8Bc34A);
const kColorRose = Color(0xffeb154e);

const kInputTextStyle = TextStyle(
    fontSize: 14,
    color: kColorDarkBlue,
    fontWeight: FontWeight.w300,
    fontFamily: 'NunitoSans');

const kBottomPadding = 48.0;

const kTextStyleButton = TextStyle(
  color: kColorPrimary,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: 'NunitoSans',
);

const kTextStyleSubtitle1 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: 'NunitoSans',
);

const kTextStyleSubtitle2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'NunitoSans',
);

const kTextStyleBody2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'NunitoSans',
);

const kTextStyleHeadline6 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  fontFamily: 'NunitoSans',
);
ButtonStyle recordButtonStyle = TextButton.styleFrom(
  foregroundColor: kColorPrimary,
  fixedSize: const Size(36, 36),
  padding: const EdgeInsets.all(0),
);

ButtonStyle roundedButtonStyle = TextButton.styleFrom(
  foregroundColor: kColorPrimary,
  elevation: 1,
  fixedSize: const Size(36, 36),
  padding: const EdgeInsets.all(0),
  shape: const CircleBorder(),
);

BoxDecoration roundedButtonDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5), //color of shadow
      spreadRadius: 1, //spread radius
      blurRadius: 1, // blur radius
      offset: const Offset(0, 1),
    ),
  ],
);

const notificationTag = 'notifications';
