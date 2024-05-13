import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Click_article/repository/widgets/icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ArticleMain extends StatefulWidget {
  const ArticleMain({super.key});

  @override
  State<ArticleMain> createState() => _ArticleMainState();
}

class _ArticleMainState extends State<ArticleMain> {
  bool scrollbool = false;
  ScrollController controller = ScrollController();
  List<dynamic> articleNames = [];

  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  loadArticleNames() async {
    DBhelper dbHelper = DBhelper();
    List<Map<String, dynamic>> articles =
        await dbHelper.getContent(Get.arguments);
    setState(() {
      articleNames = articles.map((article) => article['_text']).toList();
    });
  }

  Future<List> loadContent() async {
    return articleNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Builder(builder: (context) {
                return CommonIcon.icon(
                  icon: Icons.music_note,
                  event: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          width: EsaySize.width(context),
                          height: EsaySize.height(context) * 0.3,
                          decoration: BoxDecoration(
                            gradient: CustomGr.gradient(),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: SliderTheme(
                                  data: SliderThemeData(
                                      thumbColor: Colors.blue.shade200,
                                      trackHeight: 3,
                                      activeTrackColor: Colors.blue.shade200),
                                  child: Slider(
                                    value: 0.5,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "00.00",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "00.37",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.blue.shade200,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: Icons.star,
                event: () {
                  Get.snackbar(
                    "رسالة",
                    "حفظ بنجاح.",
                    messageText: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "حفظ بنجاح.",
                          style: TextStyle(fontSize: 14),
                        )),
                    titleText: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "رسالة",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                    duration: const Duration(milliseconds: 1250),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(10),
                  );
                },
              ),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: FontAwesomeIcons.scroll,
                event: () {
                  scrollbool = !scrollbool;

                  if (scrollbool) {
                    controller
                        .animateTo(controller.position.maxScrollExtent,
                            duration: const Duration(seconds: 10),
                            curve: Curves.linear)
                        .then((value) {
                      if (controller.position.pixels ==
                          controller.position.maxScrollExtent) {
                        scrollbool = false;
                      }
                    });
                  } else {
                    controller.animateTo(controller.position.pixels,
                        duration: const Duration(seconds: 1),
                        curve: Curves.slowMiddle);
                  }
                },
              ),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: FontAwesomeIcons.minus,
                event: () {},
              ),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: FontAwesomeIcons.plus,
                event: () {},
              ),
              EsaySize.gap(8),
            ],
          )
        ],
      ),
      body: Container(
        width: EsaySize.width(context),
        height: EsaySize.height(context),
        decoration: const BoxDecoration(color: Colors.white),
        child: FutureBuilder(
          future: loadContent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CostumLoading.fadingCircle(context));
            } else if (snapshot.hasData) {
              return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 5, left: 8, right: 8),
                          child: Text(
                            NameCat.nameTitle,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            snapshot.data!.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
