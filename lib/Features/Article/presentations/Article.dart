import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/Click_article.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  List<dynamic> articleNames = [];

  @override
  initState() {
    super.initState();
    loadArticleNames();
  }

  void loadArticleNames() async {
    DBhelper dbHelper = DBhelper();
    List<Map<String, dynamic>> articles = await dbHelper.getCat();
    setState(() {
      articleNames = articles.map((article) => article['name']).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                NameCat.nameCategory = articleNames[index];
                GetRoute.route(const Clickarticle(), arg: index + 1);
              },
              child: Container(
                width: EsaySize.width(context),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Center(
                    child: Text(
                  articleNames[index],
                  style: TextStyle(
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
          itemCount: articleNames.length),
    );
  }
}
