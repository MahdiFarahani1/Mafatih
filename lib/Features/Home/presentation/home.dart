import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/About_Us/presentations/screens/about_us_page.dart';
import 'package:flutter_application_1/Features/Article/presentations/Article.dart';
import 'package:flutter_application_1/Features/Favorite/presentations/Favorite.dart';
import 'package:flutter_application_1/Features/Search/presentations/Search.dart';
import 'package:flutter_application_1/Features/Setting/presentations/Setting.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var changer = false;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: EsaySize.width(context),
            height: EsaySize.height(context),
            decoration: BoxDecoration(gradient: CustomGr.gradient()),
            child: StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: EsaySize.height(context) * 0.13,
                ),
                child: changer
                    ? Text(
                        "مناسك الحج",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.blue.shade100,
                            fontWeight: FontWeight.bold),
                      )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 1500))
                        .moveX()
                    : DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          repeatForever: false,
                          onFinished: () {
                            setState(
                              () {
                                changer = true;
                              },
                            );
                          },
                          pause: const Duration(milliseconds: 1200),
                          animatedTexts: [
                            RotateAnimatedText('تطبيق مناسك الحج'),
                            RotateAnimatedText('لبيك اللهم لبيك'),
                            RotateAnimatedText('لبيك لا شريك لك لبيك'),
                          ],
                          onTap: () {},
                        ),
                      ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: EsaySize.width(context),
              height: EsaySize.height(context) * 0.6,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Center(
                child: InkResponse(
                  onTap: () {
                    DBhelper().initDb();
                    GetRoute.route(const Article());
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.images.coHajjApp512.path)),
                      gradient: CustomGr.gradient(),
                      borderRadius: BorderRadius.circular(32),
                    ),
                  )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 1000))
                      .moveX(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: EsaySize.width(context) * 0.8,
          height: 80,
          decoration: BoxDecoration(
              gradient: CustomGr.gradient(),
              borderRadius: BorderRadius.circular(35)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      GetRoute.route(const Setting());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        size: 30,
                        Icons.settings,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      GetRoute.route(const AboutUs());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        size: 30,
                        Icons.info,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      GetRoute.route(const Search());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        size: 30,
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      GetRoute.route(const Favorite());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        size: 30,
                        Icons.favorite,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 1500))
                .moveX(),
          ),
        ),
      ),
    );
  }
}
