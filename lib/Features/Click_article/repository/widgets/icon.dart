import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';

class CommonIcon {
  static Widget icon(
      {required IconData icon,
      required VoidCallback event,
      required BuildContext context,
      bool? withoutBorder = false}) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        event();
      },
      child: !withoutBorder!
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: ConstColor.Col3),
                  shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 20,
                color: ConstColor.Col3,
              ),
            )
          : Icon(
              icon,
              size: 20,
              color: ConstColor.Col3,
            ),
    );
  }
}
