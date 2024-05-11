import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: EsaySize.width(context),
            height: EsaySize.height(context),
            decoration: BoxDecoration(gradient: CustomGr.gradient()),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: EsaySize.height(context) * 0.13,
              ),
              child: const Text(
                "home is take it",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 1500))
                  .moveX(),
            ),
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
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      gradient: CustomGr.gradient(),
                      borderRadius: BorderRadius.circular(36)),
                  child: const Icon(
                    Icons.menu_book,
                    size: 50,
                    color: Colors.white,
                  ),
                )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 1500))
                    .moveX(),
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
              borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      size: 30,
                      Icons.settings,
                      color: Colors.orangeAccent.shade400,
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      size: 30,
                      Icons.info,
                      color: Colors.orangeAccent.shade400,
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      size: 30,
                      Icons.search,
                      color: Colors.orangeAccent.shade400,
                    ),
                  ),
                ),
                EsaySize.safeGap(45),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      size: 30,
                      Icons.favorite,
                      color: Colors.orangeAccent.shade400,
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
