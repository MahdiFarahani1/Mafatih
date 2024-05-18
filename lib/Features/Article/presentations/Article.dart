import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Article/presentations/article2.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/article_lastList.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
    articles = dbHelper.getArticle(0);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: cheker,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: CommonAppbar.appbar(true, context),
        body: buildListView(),
      ),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> buildListView() {
    return FutureBuilder(
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
                            GetRoute.route(const ArticleLastList(),
                                arg: lastParentId);
                          } else {
                            GetRoute.route(const Article2(), arg: lastParentId);
                          }
                        },
                      );

                      // articles!.then(
                      //   (value) {
                      //     if (value.isEmpty) {
                      //       GetRoute.route(const ArticleMain(),
                      //           arg: lastParentId);
                      //     }
                      //   },
                      // );
                    },
                    child: Container(
                      width: EsaySize.width(context),
                      height: 50,
                      decoration: CustomGr.dec(),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: Center(
                          child: Text(
                        snapshot.data?[index]["title"],
                        style: TextStyle(
                            fontSize: 17,
                            color: ConstColor.Col3,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    endIndent: 60,
                    indent: 60,
                    color: ConstColor.Col0,
                  );
                },
                itemCount: snapshot.data!.length);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CostumLoading.loadCircle(context);
          }
          return const SizedBox.shrink();
        });
  }
}
