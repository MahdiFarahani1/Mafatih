import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Features/Article/presentations/Article3.dart';
import 'package:flutter_application_1/Features/Article/presentations/widget/list_articles.dart';

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
        appBar: CommonAppbar.appbar(false, context),
        body: ListArticles.list(
            articles: articles,
            lastParentId: lastParentId,
            dbHelper: dbHelper,
            myClass: const Article3()),
      ),
    );
  }
}
