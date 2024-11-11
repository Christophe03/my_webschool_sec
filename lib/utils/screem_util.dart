import 'package:flutter/material.dart';

bool isDeviceTablet(BuildContext context) {
  // Calculate the screen width
  double screenWidth = MediaQuery.of(context).size.width;

  // Set a threshold width to distinguish tablets from phones
  double tabletThreshold = 600;

  // Check if the screen width is greater than the threshold
  return screenWidth > tabletThreshold;
}
