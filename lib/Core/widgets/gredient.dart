import 'package:flutter/material.dart';

class CustomGr {
  static LinearGradient gradient() {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      Colors.blue.shade900,
      Colors.blue.shade800,
      Colors.blue.shade400,
    ]);
  }
}
