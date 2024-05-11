import 'package:flutter/material.dart';

class CustomGr {
  static LinearGradient gradient() {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      Colors.orange.shade900,
      Colors.orange.shade800,
      Colors.orange.shade400,
    ]);
  }
}
