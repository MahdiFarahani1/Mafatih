import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/icon_appbar.dart';
import 'package:flutter_application_1/Features/Article/presentations/Article3.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_main_page.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:get/get.dart';

class Article2 extends StatefulWidget {
  const Article2({super.key});

  @override
  State<Article2> createState() => _ArticleState();
}

class _ArticleState extends State<Article2> {
  bool cheker = true;
  Future<List<Map<String, dynamic>>>? articles;
  DBhelper dbHelper = DBhelper();
  int lastParentId = 0;

  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  void loadArticleNames() {
    articles = dbHelper.getArticle(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: cheker,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            NameCat.nameCategory,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          actions: [
            IconBar.icon(),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          NameCat.nameCategory = snapshot.data?[index]['title'];
                          lastParentId = snapshot.data?[index]['id'];

                          articles = dbHelper.getArticle(lastParentId);
                          articles!.then(
                            (value) {
                              if (value.isEmpty) {
                                GetRoute.route(const ArticleMain(),
                                    arg: lastParentId);
                              } else {
                                GetRoute.route(const Article3(),
                                    arg: lastParentId);
                              }
                            },
                          );
                        },
                        child: Container(
                          width: EsaySize.width(context),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 12),
                          child: Center(
                              child: Text(
                            snapshot.data?[index]["title"],
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        endIndent: 60,
                        indent: 60,
                        color: Colors.blue.shade900,
                      );
                    },
                    itemCount: snapshot.data!.length);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CostumLoading.loadCircle(context);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
