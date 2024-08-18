import 'dart:math';
import 'package:app_streaming/utils/color_extension.dart';
import 'package:flutter/material.dart';

class UserProfile {
  String name;
  String? avatarUrl;
  late Color color;

  UserProfile({
    required this.name,
    this.avatarUrl,
    int? seed,
  }) {
    color = _generateColor(seed: seed);
  }

  Color _generateColor({int? seed}) {
    final Random random = seed != null ? Random(seed) : Random();
    Color randomColor = Colors.red;

    while (!randomColor.isColorContrastingWithWhite()) {
      randomColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    }

    return randomColor;
  }
}
