import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';

class CustomGr {
  static LinearGradient gradient() {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      ConstColor.Col0,
      ConstColor.Col1,
      ConstColor.Col2,
    ]);
  }

  static LinearGradient gradientLeft() {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      ConstColor.Col2,
      ConstColor.Col1,
      ConstColor.Col0,
    ]);
  }

  static BoxDecoration dec() {
    return BoxDecoration(
        border: Border.all(
          color: ConstColor.Col3,
          width: 2,
        ),
        color: ConstColor.Col1,
        borderRadius: BorderRadius.circular(4));
  }
}
