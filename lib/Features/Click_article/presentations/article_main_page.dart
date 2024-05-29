import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/bloc/audio/audio_cubit.dart';
import 'package:flutter_application_1/Features/Click_article/repository/foramt_duration.dart';
import 'package:flutter_application_1/Features/Click_article/repository/widgets/icon.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';
import 'package:flutter_application_1/Features/Setting/presentations/Setting.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/setting/settings_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ArticleMain extends StatefulWidget {
  final bool isSearchMode;
  final String txtSearch;
  const ArticleMain(
      {super.key, this.isSearchMode = false, this.txtSearch = ""});

  @override
  State<ArticleMain> createState() => _ArticleMainState();
}

class _ArticleMainState extends State<ArticleMain> {
  FlickManager? flickManager;
  ArticleMode mode = ArticleMode.onlyHasText;

  ///music
  final audio = AudioPlayer();
  String urlMusic = "";

  ///music

  late int idSave;
  late bool checkIcon = false;
  bool scrollbool = false;
  ScrollController controller = ScrollController();

  Future<List<Map<String, dynamic>>>? articles;

  double _playbackRate = 1.0;
  final List<double> _playbackRates = [1.0, 1.5, 2.0];
  int _currentRateIndex = 0;

  void _togglePlaybackRate() {
    _currentRateIndex = (_currentRateIndex + 1) % _playbackRates.length;
    _playbackRate = _playbackRates[_currentRateIndex];
    audio.setPlaybackRate(_playbackRate);
    setState(() {});
  }

  @override
  initState() {
    BlocProvider.of<AudioCubit>(context).initState(audio);

    super.initState();
    loadArticleNames();
  }

  @override
  void dispose() {
    audio.dispose();
    flickManager?.dispose();
    super.dispose();
  }

  loadArticleNames() {
    DBhelper dbHelper = DBhelper();
    articles = dbHelper.getRealArticle(Get.arguments as int);
    articles!.then((value) async {
      print(value);

      setState(
        () {
          idSave = value[0]["id"];
          checkIcon = box.read("icon$idSave") ?? false;
          idSave = value[0]["id"];
          checkIcon = box.read("icon$idSave") ?? false;
          if (value.any((element) =>
                  element["sound"] == "" || element["sound"] == null) &&
              value.any((element) => element["video"] == null) &&
              value.any((element) => element["image"] == null)) {
            mode = ArticleMode.onlyHasText;
          } else if (value.any((element) => element["_text"] == null) &&
              value.any((element) => element["video"] == null) &&
              value.any((element) => element["image"] == null)) {
            urlMusic = value[0]["sound"];
            mode = ArticleMode.onlyHasSound;
          } else if (value.any((element) => element["_text"] == null) &&
              value.any((element) => element["sound"] == null) &&
              value.any((element) => element["image"] == null)) {
            // Directory downloadsDirectory =
            //     await getDownloadsDirectory() ?? await getTemporaryDirectory();
            // final File file =
            //     File('${downloadsDirectory.path}/${value[0]["id"]}');
            // if (await file.exists()) {
            // print(file);
            // print(
            //     "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  has video !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            // FlickManager(
            //   videoPlayerController: VideoPlayerController.file(file),
            // );
            // } else {
            // print(
            //     "!!!!!!!!!!!!!!!!!!!!!!!!!!!!! dont has video !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

            // FileDownloader.downloadFile(
            //   onProgress: (fileName, progress) {},
            //   notificationType: NotificationType.all,
            //   url: value[0]["video"],
            //   name: value[0]["id"].toString(),
            //   onDownloadCompleted: (String path) async {
            //     box.write("video${value[0]["id"]}", path);
            //   },
            // );
            flickManager = FlickManager(
              videoPlayerController: VideoPlayerController.networkUrl(
                Uri.parse(value[0]["video"]),
              ),
            );
            mode = ArticleMode.onlyHasVideo;
            // }
          } else if (value.any((element) => element["_text"] != null) &&
              value.any((element) => element["sound"] != null) &&
              value.any((element) => element["image"] == null)) {
            urlMusic = value[0]["sound"];
            print(urlMusic);

            mode = ArticleMode.soundAndtext;
          } else if (value.any((element) => element["image"] != null)) {
            mode = ArticleMode.onlyHaspicture;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        BlocProvider.of<AudioCubit>(context).dispose();
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingBtn(context),
        appBar: appBar(context),
        body: Container(
          width: EsaySize.width(context),
          height: EsaySize.height(context),
          decoration: const BoxDecoration(color: Colors.white),
          child: buildListView(),
        ),
        bottomNavigationBar:
            mode == ArticleMode.onlyHasSound || mode == ArticleMode.soundAndtext
                ? bottomAppBar()
                : const SizedBox(),
      ),
    );
  }

  BlocBuilder<AudioCubit, AudioState> bottomAppBar() {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        return BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          padding: const EdgeInsets.all(0),
          elevation: 0,
          notchMargin: 4,
          color: Colors.white,
          height: 90,
          child: Container(
            width: EsaySize.width(context),
            height: 90,
            decoration: BoxDecoration(
                gradient: CustomGr.gradient(context),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18))),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Text(
                      FormatDuration.formatDuration(
                          state.duration - state.position),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        thumbColor:
                            BlocProvider.of<ThemeCubit>(context).state.Col2,
                        trackHeight: 2,
                        activeTrackColor:
                            BlocProvider.of<ThemeCubit>(context).state.Col2),
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Slider(
                          min: 0,
                          max: state.duration.inSeconds > 0
                              ? state.duration.inSeconds.toDouble()
                              : 1,
                          value: state.position.inSeconds
                              .toDouble()
                              .clamp(0.0, state.duration.inSeconds.toDouble()),
                          onChanged: (value) async {
                            final pos = Duration(seconds: value.toInt());
                            await audio.seek(pos);
                            await audio.resume();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      articles!.then((value) async {
                        final filePath = box.read("audio${value[0]["id"]}");

                        if (await File(filePath.toString()).exists()) {
                          await BlocProvider.of<AudioCubit>(context)
                              .changeIcon(audio, urlMusic, idSave);
                        } else {
                          await BlocProvider.of<AudioCubit>(context)
                              .networkAudio(audio, urlMusic, idSave);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: const Offset(2, 2),
                              color: BlocProvider.of<ThemeCubit>(context)
                                  .state
                                  .Col1)
                        ], color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          state.icon,
                          size: 30,
                          color:
                              BlocProvider.of<ThemeCubit>(context).state.Col2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                      ),
                      onPressed: _togglePlaybackRate,
                      child: Text(
                        'x$_playbackRate',
                        style: TextStyle(
                            color: BlocProvider.of<ThemeCubit>(context)
                                .state
                                .Col2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SpeedDial floatingBtn(BuildContext context) {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.red,
      activeForegroundColor: Colors.white,
      visible: true,
      gradient: CustomGr.gradient(context),
      gradientBoxShape: BoxShape.circle,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Transform.scale(
              scale: 1,
              child: Icon(
                Icons.home_outlined,
                color: BlocProvider.of<ThemeCubit>(context).state.Col3,
              )),
          backgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col0,
          labelBackgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col3,
          label: 'الرئيسية',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () {
            GetRoute.route(const MyHomePage(), context: context);
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.settings_outlined,
            color: BlocProvider.of<ThemeCubit>(context).state.Col3,
          ),
          backgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col0,
          labelBackgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col3,
          label: 'الاعدادات',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () {
            GetRoute.route(const Setting(), context: context);
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.share_outlined,
            color: BlocProvider.of<ThemeCubit>(context).state.Col3,
          ),
          backgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col0,
          labelBackgroundColor: BlocProvider.of<ThemeCubit>(context).state.Col3,
          label: 'مشاركة',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () {
            articles?.then((value) {
              String shareContent =
                  "${value[0]["title"]}\n${value[0]["_text"]}";

              switch (mode) {
                case ArticleMode.onlyHasSound:
                  shareContent = "${value[0]["title"]}\n${value[0]["sound"]}";
                  break;
                case ArticleMode.onlyHasText:
                  shareContent = "${value[0]["title"]}\n${value[0]["_text"]}";
                  break;
                case ArticleMode.onlyHasVideo:
                  shareContent = "${value[0]["title"]}\n${value[0]["video"]}";
                case ArticleMode.onlyHaspicture:
                  shareContent = "${value[0]["title"]}\n${value[0]["image"]}";
                case ArticleMode.soundAndtext:
                  shareContent =
                      "${value[0]["title"]}\n${value[0]["_text"]}\n${value[0]["sound"]}";

                default:
              }
              Share.share(shareContent);
            });
          },
        ),
      ],
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> buildListView() {
    return FutureBuilder(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CostumLoading.fadingCircle(context));
        } else if (snapshot.hasData) {
          switch (mode) {
            case ArticleMode.onlyHasSound:
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data![0]['title'],
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ));
            case ArticleMode.onlyHasVideo:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data?[0]['title'],
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  EsaySize.gap(60),
                  Builder(builder: (context) {
                    return FlickVideoPlayer(
                      flickManager: flickManager!,
                    );
                  })
                ],
              );
            case ArticleMode.soundAndtext:
              return text(snapshot);
            case ArticleMode.onlyHasText:
              return text(snapshot);
            case ArticleMode.onlyHaspicture:
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data?[0]['title'],
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 4.0,
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data?[0]['image'],
                      placeholder: (context, url) {
                        return Center(
                          child: CostumLoading.fadingCircle(context),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Directionality text(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Scrollbar(
                  thickness: 3,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: controller,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 5, left: 8, right: 8),
                              child: Text(
                                snapshot.data![0]['title'] ?? "",
                                style: TextStyle(
                                    fontFamily: state.fontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: BlocBuilder<SettingsCubit, SettingsState>(
                                builder: (context, state) {
                                  return widget.isSearchMode
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 70),
                                          child: TextHighlight(
                                            textDirection: TextDirection.rtl,
                                            text: snapshot.data?[0]['_text'],
                                            words: {
                                              widget.txtSearch: HighlightedWord(
                                                  textStyle: TextStyle(
                                                      fontFamily:
                                                          state.fontFamily,
                                                      color: Colors.red,
                                                      fontSize: state.fontSize))
                                            },
                                            textStyle: TextStyle(
                                              fontFamily: state.fontFamily,
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 70),
                                          child: Text(
                                            snapshot.data?[0]['_text'],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontFamily: state.fontFamily,
                                                color: Colors.black,
                                                fontSize: state.fontSize),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: CustomGr.gradient(context)),
      ),
      actions: [
        Row(
          children: [
            mode == ArticleMode.onlyHasVideo
                ? CommonIcon.icon(
                    icon: FontAwesomeIcons.download,
                    event: () {
                      articles!.then((value) {
                        FileDownloader.downloadFile(
                          onProgress: (fileName, progress) {},
                          notificationType: NotificationType.all,
                          url: value[0]["video"],
                          name: value[0]["id"].toString(),
                          onDownloadCompleted: (String path) async {
                            //     box.write("audio${value[0]["id"]}", path);
                            // await BlocProvider.of<AudioCubit>(context)
                            //     .changeIcon(audio, urlMusic, idSave);
                          },
                        );
                      });
                    },
                    context: context)
                : const SizedBox(),
            mode == ArticleMode.onlyHasSound || mode == ArticleMode.soundAndtext
                ? CommonIcon.icon(
                    icon: FontAwesomeIcons.download,
                    event: () {
                      articles!.then((value) {
                        FileDownloader.downloadFile(
                          onProgress: (fileName, progress) {},
                          notificationType: NotificationType.all,
                          url: value[0]["sound"],
                          name: value[0]["id"].toString(),
                          onDownloadCompleted: (String path) async {
                            box.write("audio${value[0]["id"]}", path);
                            // await BlocProvider.of<AudioCubit>(context)
                            //     .changeIcon(audio, urlMusic, idSave);
                          },
                        );
                      });

                      Get.snackbar(
                        "تنبيه",
                        "جاري التحميل .. يرجى الانتظار",
                        messageText: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "جاري التحميل .. يرجى الانتظار",
                              style: TextStyle(fontSize: 14),
                            )),
                        titleText: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "رسالة",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                        margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: EsaySize.height(context) * 0.2),
                      );
                    },
                    context: context)
                : const SizedBox(),
            EsaySize.gap(8),
            StatefulBuilder(builder: (context, setStateReal) {
              return CircleAvatar(
                child: CommonIcon.icon(
                  context: context,
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
                  },
                ),
              );
            }),
            EsaySize.gap(8),
            mode == ArticleMode.onlyHasText || mode == ArticleMode.soundAndtext
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        scrollbool = !scrollbool;
                      });
                      if (scrollbool) {
                        articles!.then((value) {
                          String size = value[0]["_text"];
                          if (size.length <= 3000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 50),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }
                          if (size.length > 3000 && size.length <= 6000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 160),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }
                          if (size.length > 6000 && size.length <= 9000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 240),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }

                          if (size.length > 9000 && size.length <= 12000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 320),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }
                          if (size.length > 12000 && size.length <= 15000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 400),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }
                          if (size.length > 15000) {
                            controller
                                .animateTo(controller.position.maxScrollExtent,
                                    duration: const Duration(seconds: 700),
                                    curve: Curves.linear)
                                .then((value) {
                              if (controller.position.pixels ==
                                  controller.position.maxScrollExtent) {
                                scrollbool = false;
                              }
                            });
                          }
                        });
                      } else {
                        controller.animateTo(controller.position.pixels,
                            duration: const Duration(seconds: 1),
                            curve: Curves.slowMiddle);
                      }
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: BlocProvider.of<ThemeCubit>(context)
                                      .state
                                      .Col0,
                                  offset: const Offset(4, 4))
                            ],
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: BlocProvider.of<ThemeCubit>(context)
                                    .state
                                    .Col3),
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Assets.images.upArrows.image(),
                        )),
                  )
                : const SizedBox(),
            EsaySize.gap(8),
            mode == ArticleMode.onlyHasText || mode == ArticleMode.soundAndtext
                ? CommonIcon.icon(
                    context: context,
                    icon: FontAwesomeIcons.minus,
                    event: () {
                      BlocProvider.of<SettingsCubit>(context).nagitivFont();
                    },
                  )
                : const SizedBox(),
            EsaySize.gap(8),
            mode == ArticleMode.onlyHasText || mode == ArticleMode.soundAndtext
                ? CommonIcon.icon(
                    context: context,
                    icon: FontAwesomeIcons.plus,
                    event: () {
                      BlocProvider.of<SettingsCubit>(context).plusFont();
                    },
                  )
                : const SizedBox(),
            EsaySize.gap(8),
          ],
        )
      ],
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
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
    );
  }
}

enum ArticleMode {
  onlyHasSound,
  onlyHasVideo,
  onlyHasText,
  onlyHaspicture,

  soundAndtext,
}
