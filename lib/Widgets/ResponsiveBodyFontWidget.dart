import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Get screen width and height to adjust UI elements dynamically
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final double textScaleFactor;

  ResponsiveUtils(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height,
        textScaleFactor = MediaQuery.of(context).textScaleFactor;

  // Method to get dynamic font size based on screen width
  double getAppBarFontSize() {
    return screenWidth > 600 ? 18 * textScaleFactor : 16 * textScaleFactor;
  }

  double getTitleFontSize() {
    return screenWidth > 600 ? 16 * textScaleFactor : 14 * textScaleFactor;
  }

  double getBodyFontSize() {
    return screenWidth > 600 ? 14 * textScaleFactor : 12 * textScaleFactor;
  }

  double getNormalRangeFontSize() {
    return screenWidth > 600 ? 12 * textScaleFactor : 10 * textScaleFactor;
  }

  // Example method to adjust padding based on screen size
  EdgeInsets getDefaultPadding() {
    return screenWidth > 600 ? const EdgeInsets.all(20) : const EdgeInsets.all(16);
  }
}
