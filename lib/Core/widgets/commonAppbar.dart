import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class CommonAppbar {
  static AppBar appbar(bool isNormalMode, BuildContext context) {
    return isNormalMode
        ? AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: CustomGr.gradient()),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    GetRoute.route(const MyHomePage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.images.homeA.image(width: 30, height: 30),
                  )),
            ],
          )
        : AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: CustomGr.gradient()),
            ),
            title: Text(
              NameCat.nameCategory,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Assets.images.homeA.image(width: 30, height: 30),
              ),
            ],
            centerTitle: true,
          );
  }
}
