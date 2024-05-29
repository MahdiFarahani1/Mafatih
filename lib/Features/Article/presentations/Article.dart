import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Features/Article/presentations/article2.dart';
import 'package:flutter_application_1/Features/Article/presentations/widget/list_articles.dart';
import 'package:flutter_application_1/Features/Home/presentation/bloc/bloc/audio_home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      onPopInvoked: (didPop) {
        BlocProvider.of<AudioHomeBloc>(context).add(PlayAudio());
      },
      child: Scaffold(
        appBar: CommonAppbar.appbar(true, context),
        body: ListArticles.list(
            articles: articles,
            lastParentId: lastParentId,
            dbHelper: dbHelper,
            myClass: const Article2()),
      ),
    );
  }
}
