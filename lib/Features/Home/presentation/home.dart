import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/About_Us/presentations/screens/about_us_page.dart';
import 'package:flutter_application_1/Features/Article/presentations/Article.dart';
import 'package:flutter_application_1/Features/Favorite/presentations/Favorite.dart';
import 'package:flutter_application_1/Features/Search/presentations/Search.dart';
import 'package:flutter_application_1/Features/Setting/presentations/Setting.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_application_1/gen/fonts.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var changer = false;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          GetRoute.route(const Article());
        },
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return CircleAvatar(
                radius: 35,
                backgroundColor: state.Col0,
                child: LottieBuilder.asset(
                  Assets.lottie.list,
                  reverse: true,
                ));
          },
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Container(
                alignment: Alignment.topCenter,
                width: EsaySize.width(context),
                height: EsaySize.height(context),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                  state.Col0,
                  state.Col1,
                  state.Col2,
                ])),
                child: animatedAppbar(changer),
              );
            },
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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 60, right: 60, top: 0, bottom: 140),
                child: InkResponse(
                        onTap: () async {
                          GetRoute.route(const Article());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: GestureDetector(
                              onTap: () {
                                GetRoute.route(const Article());
                              },
                              child: Assets.images.logoMain
                                  .image(width: 200, height: 200)),
                        ))
                    .animate()
                    .fade(duration: const Duration(milliseconds: 1000))
                    .moveX(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                GetRoute.route(const AboutUs());
              },
              child: Assets.images.logoMainPage
                  .image(height: 200, width: 200)
                  .animate()
                  .fade(duration: const Duration(milliseconds: 1000))
                  .moveX(),
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  StatefulBuilder animatedAppbar(bool changer) {
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: EsaySize.height(context) * 0.13,
        ),
        child: changer
            ? Text(
                "دليل الحاج",
                style: TextStyle(
                    fontSize: 28,
                    color: BlocProvider.of<ThemeCubit>(context).state.Col3,
                    fontWeight: FontWeight.bold),
              )
                .animate()
                .fade(duration: const Duration(milliseconds: 1500))
                .moveX()
            : DefaultTextStyle(
                style: const TextStyle(
                    fontFamily: FontFamily.arabic,
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
                  pause: const Duration(milliseconds: 800),
                  animatedTexts: [
                    RotateAnimatedText('لبيك اللهم لبيك'),
                    RotateAnimatedText('لبيك لا شريك لك لبيك'),
                  ],
                  onTap: () {},
                ),
              ),
      );
    });
  }

  Widget bottomNavBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.all(0),
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Container(
            height: 100,
            width: EsaySize.width(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                state.Col0,
                state.Col1,
                state.Col2,
              ]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    GetRoute.route(const Setting());
                  },
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.white,
                    child: Assets.images.settings
                        .image(fit: BoxFit.contain, width: 40, height: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GetRoute.route(const AboutUs());
                  },
                  child: CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.white,
                      child: Assets.images.information
                          .image(width: 40, height: 40)),
                ),
                const SizedBox(width: 60),
                GestureDetector(
                  onTap: () {
                    GetRoute.route(const Search());
                  },
                  child: CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.white,
                      child: Assets.images.search.image(width: 40, height: 40)),
                ),
                GestureDetector(
                  onTap: () {
                    GetRoute.route(const Favorite());
                  },
                  child: CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.white,
                      child: Assets.images.fav.image(width: 40, height: 40)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
