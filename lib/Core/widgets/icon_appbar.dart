import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';

class IconBar {
  static Widget icon() {
    return IconButton(
      icon: const Icon(
        Icons.home_filled,
        size: 30,
      ),
      onPressed: () {
        GetRoute.route(const MyHomePage());
      },
    );
  }
}
