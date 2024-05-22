import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';

class CommonBox {
  static Widget txt(String text, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      width: EsaySize.width(context),
      decoration: CustomGr.dec(context),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            textDirection: TextDirection.rtl,
            text,
            style: const TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
