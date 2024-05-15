import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/repository/widgets/icon.dart';
import 'package:flutter_application_1/Features/Setting/presentations/cubit/settings_cubit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ArticleMain extends StatefulWidget {
  const ArticleMain({super.key});

  @override
  State<ArticleMain> createState() => _ArticleMainState();
}

class _ArticleMainState extends State<ArticleMain> {
  late int idSave;
  late bool checkIcon = false;
  bool hasSound = true;
  bool scrollbool = false;
  ScrollController controller = ScrollController();

  Future<List<Map<String, dynamic>>>? articles;
  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  loadArticleNames() {
    DBhelper dbHelper = DBhelper();
    articles = dbHelper.getNewContent(Get.arguments as int);
    articles!.then(
      (value) {
        setState(() {
          idSave = value[0]["id"];
          checkIcon = box.read("icon$idSave") ?? false;
          idSave = value[0]["id"];
          checkIcon = box.read("icon$idSave") ?? false;
          if (value.any((element) => element["sound"] == null)) {
            print(value);
            print("is dosnt have sound");
            hasSound = false;
          } else {
            hasSound = true;
            print(value);

            print("is have sound");
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              hasSound
                  ? Builder(builder: (context) {
                      return CommonIcon.icon(
                        icon: FontAwesomeIcons.soundcloud,
                        event: () {
                          showBottomSheeT(context);
                        },
                      );
                    })
                  : const SizedBox(),
              EsaySize.gap(8),
              StatefulBuilder(builder: (context, setStateReal) {
                return CommonIcon.icon(
                  icon: !checkIcon ? FontAwesomeIcons.star : Icons.star,
                  event: () {
                    setStateReal(
                      () {
                        checkIcon = !checkIcon;
                      },
                    );
                    if (checkIcon) {
                      box.write("icon$idSave", checkIcon);
                      DBhelper dBhelper = DBhelper();
                      articles!.then((value) {
                        dBhelper.insertArticle(
                            groupId: value[0]["groupId"],
                            title: value[0]["title"],
                            id: value[0]["id"]);
                      });

                      snackbar("تمت الاضافة للمفضلة بنجاح");
                    } else {
                      box.remove("icon$idSave");
                      DBhelper dBhelper = DBhelper();
                      articles!.then((value) {
                        dBhelper.deleteArticle(id: value[0]["id"]);
                      });

                      snackbar("تم الحذف من المفضلة بنجاح");
                    }
                    DBhelper dBhelper = DBhelper();

                    var a = dBhelper.getAllsave().then((value) {
                      print(value.length);
                    });
                  },
                );
              }),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: FontAwesomeIcons.arrowUp,
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
                event: () {
                  BlocProvider.of<SettingsCubit>(context).nagitivFont();
                },
              ),
              EsaySize.gap(8),
              CommonIcon.icon(
                icon: FontAwesomeIcons.plus,
                event: () {
                  BlocProvider.of<SettingsCubit>(context).plusFont();
                },
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
          future: articles,
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
                            snapshot.data![0]['title'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, state) {
                              return Text(
                                snapshot.data![0]['_text'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: state.fontSize),
                              );
                            },
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

  SnackbarController snackbar(String content) {
    return Get.snackbar(
      "تنبيه",
      "حفظ بنجاح.",
      messageText: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          )),
      titleText: const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            "رسالة",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      duration: const Duration(milliseconds: 1250),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  PersistentBottomSheetController showBottomSheeT(BuildContext context) {
    return showBottomSheet(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "00.00",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "00.37",
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
  }
}
