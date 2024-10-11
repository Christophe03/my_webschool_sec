import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String timeAgoSinceDate(String dateString) {
  DateTime startDate = DateTime(
      int.parse(dateString.substring(0, 4)),
      int.parse(dateString.substring(4, 6)),
      int.parse(dateString.substring(6, 8)),
      int.parse(dateString.substring(8, 10)),
      int.parse(dateString.substring(10, 12)),
      int.parse(dateString.substring(12, 14)));

  final date2 = DateTime.now();
  final difference = date2.difference(startDate);

  if (difference.inDays > 8) {
    return '${dateString.substring(6, 8)}/${dateString.substring(4, 6)}/${dateString.substring(0, 4)}';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return 'last_week'.tr();
  } else if (difference.inDays >= 2) {
    return '${'ilyab'.tr()} ${difference.inDays} ${'days_ago'.tr()}';
  } else if (difference.inDays >= 1) {
    return 'yesterday'.tr();
  } else if (difference.inHours >= 2) {
    return '${'ilyab'.tr()} ${difference.inHours} ${'hours_ago'.tr()}';
  } else if (difference.inHours >= 1) {
    return 'an_hour_ago'.tr();
  } else if (difference.inMinutes >= 2) {
    return '${'ilyab'.tr()} ${difference.inMinutes} ${'minutes_ago'.tr()}';
  } else if (difference.inMinutes >= 1) {
    return 'a_minute_ago'.tr();
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'just_now'.tr();
  }
}

String formatPubDateTime(String timestamp) {
  return '${timestamp.substring(6, 8)}/${timestamp.substring(4, 6)}/${timestamp.substring(0, 4)}, ${timestamp.substring(8, 10)}:${timestamp.substring(10, 12)}';
}

String formatPubDate(String timestamp) {
  return '${timestamp.substring(6, 8)}/${timestamp.substring(4, 6)}/${timestamp.substring(0, 4)}';
}

String formatDateFirebase(String timestamp) {
  if (timestamp.length > 6)
    return '${timestamp.substring(8, 10)}/${timestamp.substring(5, 7)}/${timestamp.substring(0, 4)}';
  else
    return '';
}

int calculateDifferenceInDaysFirebase(String timestamp) {
  DateTime date2 = DateTime.now();
  DateTime date1 = DateTime(
      int.parse(timestamp.substring(0, 4)),
      int.parse(timestamp.substring(5, 7)),
      int.parse(timestamp.substring(8, 10)),
      0,
      0,
      0,
      0,
      0);
  Duration difference = date2.difference(date1);
  int differenceInDays = difference.inDays;
  return differenceInDays;
}

String formatPubDTime(String timestamp) {
  return '${timestamp.substring(8, 10)}:${timestamp.substring(10, 12)}';
}

bool startsWithNumber(String input) {
  // Define a regular expression to match any digit at the beginning of the string
  RegExp regex = RegExp(r'^\d');

  // Use the hasMatch method to check if the input string matches the regular expression
  return regex.hasMatch(input);
}

int calculateAge(int date) {
  DateTime? birthDate = dateTimeFromMilliseconds(date);
  int? age = 0;
  DateTime currentDate = DateTime.now();
  age = currentDate.year - birthDate.year;

  // Adjust age based on the month and day
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month &&
          currentDate.day < birthDate.day)) {
    age--;
  }
  return age;
}

int calculateDifferenceInWeeks(DateTime date1, DateTime date2) {
  int differenceInDays = date2.difference(date1).inDays;
  int differenceInWeeks = (differenceInDays / 7).round();
  return differenceInWeeks;
}

int dateStringToInt(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return date.millisecondsSinceEpoch;
}

DateTime dateTimeFromMilliseconds(int milliseconds) {
  return DateTime.fromMillisecondsSinceEpoch(milliseconds);
}

String formatDateTime(
    DateTime dateTime, String pattern, BuildContext? context) {
  if (context != null) {
    // print("CONTEXT: ${context.locale}");
    if (context.locale.toString() == 'fr') {
      // print("IS IN IF");
      return DateFormat(pattern, "fr_FR").format(dateTime);
    }
  }

  return DateFormat(
    pattern,
  ).format(dateTime);
}

String formatTimestamp(Timestamp timestamp, String pattern) {
  return DateFormat(pattern).format(
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
}

String formatDateTimeFromMilliseconds(int milliseconds, String pattern) {
  return DateFormat(pattern)
      .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}

double stringToDouble(String doubleString) {
  return double.parse(doubleString);
}

DateTime addDays(DateTime date, int days) {
  return date.add(Duration(days: days));
}

DateTime removeDays(DateTime date, int days) {
  return date.add(Duration(days: -days));
}

DateTime addMonths(DateTime dateTime, int months) {
  return Jiffy.parseFromDateTime(dateTime).add(months: months).dateTime;
}

DateTime addWeek(DateTime dateTime, int week) {
  return Jiffy.parseFromDateTime(dateTime).add(days: 7 * week).dateTime;
}

DateTime removeMonths(DateTime dateTime, int months) {
  int totalMonths = dateTime.year * 12 + dateTime.month - months;

  int newYear = totalMonths ~/ 12;
  int newMonth = totalMonths % 12 + 1;

  int newDay = dateTime.day;

  // Copy the time components
  int newHour = dateTime.hour;
  int newMinute = dateTime.minute;
  int newSecond = dateTime.second;
  int newMillisecond = dateTime.millisecond;
  int newMicrosecond = dateTime.microsecond;

  return DateTime(newYear, newMonth, newDay, newHour, newMinute, newSecond,
      newMillisecond, newMicrosecond);
}

int calculateDifferenceInDays(DateTime date1, DateTime date2) {
  Duration difference = date2.difference(date1);
  int differenceInDays = difference.inDays;
  return differenceInDays;
}

Color hexToColor(String code) {
  // Remove the hash (#) symbol if present
  if (code[0] == '#') {
    code = code.substring(1);
  }

  // Parse the hex code to an integer
  int hexInt = int.parse(code, radix: 16);

  // Create a Color object from the integer
  return Color(hexInt | 0xFF000000); // Set alpha value to fully opaque (255)
}

String formatDoubleToString(double value, {int decimalPlaces = 2}) {
  // Convert the double to a string with the specified number of decimal places
  String stringValue = value.toStringAsFixed(decimalPlaces);

  // Remove trailing zeros and the decimal point if the number is an integer
  if (stringValue.contains('.')) {
    stringValue = stringValue.replaceAll(RegExp(r'0*$'), '');
    stringValue = stringValue.replaceAll(RegExp(r'\.$'), '');
  }

  return stringValue;
}

String formatDoubleWithThousandSeparator(double value) {
  final formatter = NumberFormat("#,###.##", "fr_FR");
  return formatter.format(value);
}
