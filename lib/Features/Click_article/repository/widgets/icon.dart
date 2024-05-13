import 'package:flutter/material.dart';

class CommonIcon {
  static Widget icon({required IconData icon, required VoidCallback event}) {
    return GestureDetector(
        onLongPress: () {
          print("sadasdsa");
        },
        onTap: () {
          event();
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blue.shade800,
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ));
  }
}
