import 'dart:math';
import 'package:flutter/material.dart';

extension ContrastVerificationExtension on Color {
  double _calculateLuminance(Color color) {
    final r = color.red / 255;
    final g = color.green / 255;
    final b = color.blue / 255;

    final rLuminance =
        (r <= 0.03928) ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLuminance =
        (g <= 0.03928) ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLuminance =
        (b <= 0.03928) ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

    return 0.2126 * rLuminance + 0.7152 * gLuminance + 0.0722 * bLuminance;
  }

  double _calculateContrast(Color color1, Color color2) {
    final luminance1 = _calculateLuminance(color1);
    final luminance2 = _calculateLuminance(color2);

    final light = max(luminance1, luminance2);
    final dark = min(luminance1, luminance2);

    return (light + 0.05) / (dark + 0.05);
  }

  bool isColorContrastingWithWhite() {
    return _calculateContrast(this, Colors.white) >= 4.5;
  }
}
